module Admin
  module Deposits
    class DollarsController < ::Admin::Deposits::BaseController
      load_and_authorize_resource :class => '::Deposits::Dollar'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @oneday_dollars = @dollars.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC')
          
        @newreq = @dollars.includes(:member).
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

        @available_dollars = @dollars.includes(:member).
          with_aasm_state(:submitting, :warning, :submitted).
          order('id DESC')

        @available_dollars -= @oneday_dollars
      end

      def show
        start_at = DateTime.now.ago(60 * 60 * 24)
        flash.now[:notice] = t('.notice') if @dollar.aasm_state.accepted?
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
        @dollar.cancel!
        redirect_to :back and return
      end
      
      def update
        
        if target_params[:txid].blank?
          flash[:alert] = t('.blank_txid')
          redirect_to :back and return
        end

        

        if @dollar.update target_params
          @dollar.charge!(target_params[:txid])
         redirect_to :back and return
        else
           msg = []
          if @dollar.errors.messages.present?
            @dollar.errors.messages.map{|key,values|
              msg << " #{key}: #{values[0]}"
            }
          end
          flash[:notice] = msg.join("/n")
          redirect_to :back and return
        end
        
      end

      private
      def target_params
        params.require(:deposits_dollar).permit(:sn, :holder, :amount, :created_at, :txid)
      end
    end
  end
end

