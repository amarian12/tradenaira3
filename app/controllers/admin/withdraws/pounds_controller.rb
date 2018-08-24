module Admin
  module Withdraws
    class PoundsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Pound'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_pounds = @pounds.with_aasm_state(:accepted, :processing).order("id DESC")
        @all_pounds = @pounds.without_aasm_state(:accepted, :processing).where('created_at > ?', start_at).order("id DESC")
        @newwith = Withdraw.without_aasm_state(:accepted, :processing).
          where('created_at > ?', start_at).
          order("id DESC").count
        @newdep = Deposit.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC').count
                
        @newreq = @pounds.includes(:member).
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
        if @pound.may_process?
          @pound.process!
        elsif @pound.may_succeed?
          @pound.succeed!
        end

        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @pound.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
