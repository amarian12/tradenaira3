module Admin
  class SlidersController < BaseController
    
    def edit
      start_at = DateTime.now.ago(60 * 60 * 24)
      @slider = current_user.slider || current_user.create_slider
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

    def update
      @slider = current_user.slider

      if @slider.update_attributes slider_params
        redirect_to admin_dashboard_path
      else
        redirect_to admin_dashboard_path
      end
    end

    private

    def slider_params
      params.require(:slider).permit(:usdtxt, :poundtxt, :eurotxt)
    end
  end
end
