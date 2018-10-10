module Admin
  module Deposits
    class GhanaiansController < ::Admin::Deposits::BaseController
      load_and_authorize_resource :class => '::Deposits::Ghanaian'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @oneday_ghanaians = @ghanaians.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC')
          
        @newreq = @ghanaians.includes(:member).
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

        @available_ghanaians = @ghanaians.includes(:member).
          with_aasm_state(:submitting, :warning, :submitted).
          order('id DESC')

        @available_ghanaians -= @oneday_ghanaians
      end

      def show
        start_at = DateTime.now.ago(60 * 60 * 24)
        flash.now[:notice] = t('.notice') if @ghanaian.aasm_state.accepted?
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
        @ghanaian.cancel!
        redirect_to :back and return
      end
      
      def update
        
        if target_params[:txid].blank?
          flash[:alert] = t('.blank_txid')
          redirect_to :back and return
        end

        

        if @ghanaian.update target_params
          @ghanaian.charge!(target_params[:txid])
         redirect_to :back and return
        else
          msg = []
          if @ghanaian.errors.messages.present?
            @ghanaian.errors.messages.map{|key,values|
              msg << " #{key}: #{values[0]}"
            }
          end
          flash[:notice] = msg.join("/n")
          redirect_to :back and return
        end
        
      end

      private
      def target_params
        params.require(:deposits_ghanaian).permit(:sn, :holder, :amount, :created_at, :txid)
      end
    end
  end
end
