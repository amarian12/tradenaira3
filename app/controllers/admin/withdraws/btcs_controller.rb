module Admin
  module Withdraws
    class BtcsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Btc'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_btcs = @btcs.with_aasm_state(:accepted, :processing).order("id DESC")
        @all_btcs = @btcs.without_aasm_state(:accepted, :processing).where('created_at > ?', start_at).order("id DESC")
        @newwith = Withdraw.without_aasm_state(:accepted, :processing).
          where('created_at > ?', start_at).
          order("id DESC").count 
        @newdep = Deposit.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC').count
          
        @newreq = @btcs.includes(:member).
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
        if @btc.may_process?
          @btc.process!
        elsif @btc.may_succeed?
          @btc.succeed!
        end

        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @btc.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
