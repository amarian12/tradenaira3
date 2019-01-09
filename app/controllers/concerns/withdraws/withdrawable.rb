module Withdraws
  module Withdrawable
    extend ActiveSupport::Concern

    included do
      before_filter :fetch
    end

    def create
      @withdraw = model_kls.new(withdraw_params)

      if two_factor_auth_verified?
          update_fund_source_data
        if @withdraw.save
          @withdraw.submit!
          IddocumentMailer.sendwithdraw(current_user.email,withdraw_params[:currency],withdraw_params[:sum]).deliver
          render nothing: true
        else
          render text: @withdraw.errors.full_messages.join(', '), status: 403
        end
      else
        render text: I18n.t('private.withdraws.create.two_factors_error'), status: 403
      end
    end

    def destroy
      Withdraw.transaction do
        @withdraw = current_user.withdraws.find(params[:id]).lock!
        @withdraw.cancel
        @withdraw.save!
      end
      render nothing: true
    end

    private

    def fetch
      @account = current_user.get_account(channel.currency)
      @model = model_kls
      @fund_sources = current_user.fund_sources.with_currency(channel.currency)
      @assets = model_kls.without_aasm_state(:submitting).where(member: current_user).order(:id).reverse_order.limit(10)
    end

    def withdraw_params
      params[:withdraw][:currency] = channel.currency
      params[:withdraw][:member_id] = current_user.id
      params.require(:withdraw).permit(:fund_source, :member_id, :currency, :sum,)
    end

    def update_fund_source_data
      if params && params[:withdraw] && params[:withdraw][:fund_source]
        fund_source_id = params[:withdraw][:fund_source] 
        fs = FundSource.find_by_id(fund_source_id)
        if fs && @withdraw
          @withdraw.fund_iban         = fs.iban
          @withdraw.fund_uid          = fs.uid
          @withdraw.fund_code         = fs.code
          @withdraw.fund_account_name = fs.account_name
          @withdraw.fund_extra        = fs.extra
        end
      end
      
    end

  end
end
