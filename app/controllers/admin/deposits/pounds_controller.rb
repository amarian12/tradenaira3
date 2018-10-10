module Admin
  module Deposits
    class PoundsController < ::Admin::Deposits::BaseController
      load_and_authorize_resource :class => '::Deposits::Pound'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @oneday_pounds = @pounds.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC')
          
        @newreq = @pounds.includes(:member).
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

        @available_pounds = @pounds.includes(:member).
          with_aasm_state(:submitting, :warning, :submitted).
          order('id DESC')

        @available_pounds -= @oneday_pounds
      end

      def show
        start_at = DateTime.now.ago(60 * 60 * 24)
        flash.now[:notice] = t('.notice') if @pound.aasm_state.accepted?
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
        @pound.cancel!
        redirect_to :back and return
      end

      def update
        if target_params[:txid].blank?
          flash[:alert] = t('.blank_txid')
          redirect_to :back and return
        end

        

        if @pound.update target_params
          @pound.charge!(target_params[:txid])
         redirect_to :back and return
        else
          msg = []
          if @pound.errors.messages.present?
            @pound.errors.messages.map{|key,values|
              msg << " #{key}: #{values[0]}"
            }
          end
          flash[:notice] = msg.join("/n")
          redirect_to :back and return
        end
      end

      private
      def target_params
        params.require(:deposits_pound).permit(:sn, :holder, :amount, :created_at, :txid)
      end
    end
  end
end

