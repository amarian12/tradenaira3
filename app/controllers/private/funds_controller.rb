module Private
  class FundsController < BaseController
    layout 'funds'

    before_action :auth_activated!
    before_action :auth_verified!
    before_action :two_factor_activated!

    def index
      @deposit_channels = DepositChannel.all
      @withdraw_channels = WithdrawChannel.all
      @currencies = Currency.all.sort
      @deposits = current_user.deposits
      @accounts = current_user.accounts.enabled
      @withdraws = current_user.withdraws
      @fund_sources = current_user.fund_sources
      @banks = Bank.all
      @ngnbanks = Bank.all

      #reorder accounts 
      #@accounts.map{}
      #puts "22222222222222222222222222222222222222222222222"
      accounts = []
       
      cids =  Currency.all.sort_by { |k| k[:owait] }.map{|c| c.id}
      cids.map{|c|  
        accounts << @accounts.find_by_currency(c)
      }
      # puts "@@@@@@@@@@@"
      # puts @accounts.inspect
      # puts "2222222222222222"
      # puts accounts.inspect
      @accounts = accounts

      gon.jbuilder
    end

    def gen_address
      current_user.accounts.each do |account|
        next if not account.currency_obj.coin?

        if account.payment_addresses.blank?
          account.payment_addresses.create(currency: account.currency)
        else
          address = account.payment_addresses.last
          address.gen_address if address.address.blank?
        end
      end
      render nothing: true
    end
   def transfer
   end 

  end
end

