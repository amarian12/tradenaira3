module Admin
  class DashboardController < BaseController
    skip_load_and_authorize_resource

    def index
      @daemon_statuses = Global.daemon_statuses
      @currencies_summary = Currency.all.map(&:summary)
      @register_count = Member.count
    end

    def subscribers
    	@subscribers = Subscriber.all.page(params[:page]).per(50)
    end

    def update_subscribers
    	subscriber = Subscriber.find_by_id(params[:id])
    	unless subscriber.nil?
    		if subscriber.status
    		  subscriber.status = false
    		else
    		  subscriber.status = true	
    		end  
    		subscriber.save(validate: false)
    		flash[:notice] = "The last action was success"
    	end

    	redirect_to admin_subscribers_path
    end

    def remove_subscribers

    	subscriber = Subscriber.find_by_id(params[:id])
    	unless subscriber.nil?
    		subscriber.destroy
    		flash[:notice] = "The last action was success"
    	end

    	redirect_to admin_subscribers_path

    end

  end
end
