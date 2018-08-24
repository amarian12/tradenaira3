module Admin
  module Withdraws
    class NairasController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Naira'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_nairas = @nairas.with_aasm_state(:accepted, :processing).order("id DESC")
        @all_nairas = @nairas.without_aasm_state(:accepted, :processing).where('created_at > ?', start_at).order("id DESC")
        @newwith = Withdraw.without_aasm_state(:accepted, :processing).
          where('created_at > ?', start_at).
          order("id DESC").count
        @newdep = Deposit.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC').count    
                
        @newreq = @nairas.includes(:member).
          with_aasm_state(:rejected, :canceled).
          order('id DESC')

        @newtic = Ticket.includes(:author).
          where('created_at > ?', start_at).
          order('id DESC').count
          
        @getid = @newreq.pluck(:id)
          
      end

      def show
      end

      def update
        if @naira.may_process?
          @naira.process!
        elsif @naira.may_succeed?
          @naira.succeed!
        end

        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @naira.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
