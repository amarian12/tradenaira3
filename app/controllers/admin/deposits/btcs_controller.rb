module Admin
  module Deposits
    class BtcsController < ::Admin::Deposits::BaseController
      load_and_authorize_resource :class => '::Deposits::Btc'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @oneday_btcs = @btcs.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC')
          
        @newreq = @btcs.includes(:member).
          with_aasm_state(:cancelled).
          order('id DESC')
          
        @getid = @newreq.pluck(:id)
          
        @newdep = Deposit.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC').count
          
        @newwith = Withdraw.without_aasm_state(:accepted, :processing).
          where('created_at > ?', start_at).
          order("id DESC").count

        @newtic = Ticket.includes(:author).
          where('created_at > ?', start_at).
          order('id DESC').count

        @available_btcs = @btcs.includes(:member).
          with_aasm_state(:submitting, :warning, :submitted).
          order('id DESC')

        @available_btcs -= @oneday_btcs
      end

      def show
        start_at = DateTime.now.ago(60 * 60 * 24)
        flash.now[:notice] = t('.notice') if @btc.aasm_state.accepted?
        @newdep = Deposit.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC').count
          
        @newwith = Withdraw.without_aasm_state(:accepted, :processing).
          where('created_at > ?', start_at).
          order("id DESC").count

        @newtic = Ticket.includes(:author).
          where('created_at > ?', start_at).
          order('id DESC').count
      end
      
      def destroy
        @btc.cancel!
        redirect_to :back and return
      end
      
      def update
        
        if target_params[:txid].blank?
          flash[:alert] = t('.blank_txid')
          redirect_to :back and return
        end

        @btc.charge!(target_params[:txid])

        if @btc.update target_params
         redirect_to :back and return
        else
          redirect_to :back and return
        end
        
      end

      private
      def target_params
        params.require(:deposits_btc).permit(:sn, :holder, :amount, :created_at, :txid)
      end
    end
  end
end

