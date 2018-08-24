module Admin
  module Withdraws
    class GhanaiansController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Ghanaian'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_ghanaian = @ghanaians.with_aasm_state(:accepted, :processing).order("id DESC")
        @all_ghanaians = @ghanaians.without_aasm_state(:accepted, :processing).where('created_at > ?', start_at).order("id DESC")
        @newwith = Withdraw.without_aasm_state(:accepted, :processing).
          where('created_at > ?', start_at).
          order("id DESC").count
        @newdep = Deposit.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC').count    
                
        @newreq = @ghanaians.includes(:member).
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
        if @ghanaian.may_process?
          @ghanaian.process!
        elsif @ghanaian.may_succeed?
          @ghanaian.succeed!
        end

        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @ghanaian.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
