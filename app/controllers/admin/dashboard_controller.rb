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
      @subscriber = Subscriber.new
    end
 

    def kicksmart
      
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

    def new_subscriber
        @subscriber = Subscriber.new
        render "subscriber_form"
    end

    def send_msg
      msg           = "There are some errors:"
      errors        = false
      success       = false
      subscriber    = params[:subscriber]

      if subscriber[:contents].to_s == ""
        errors = "Please write message!"
      elsif subscriber[:subject].to_s == ""
        errors = "Please write subject!"
      else
        subscribers = subscriber[:active_only].nil? ? Subscriber.all : Subscriber.where(status: true)
        
        subscribers.each do |s|
          s.contents  = subscriber[:contents]
          s.subject   = subscriber[:subject]
          MemberMailer.subscribers_message(s).deliver
        end
        msg     = "Message sent successfully!"
        success = true
      end

      resp = { success: success, msg: msg, errors:errors, aa: subscriber[:contents]  }

      respond_to do |format|
        format.json{ render json: resp  }
      end


       
    end

    def create_subscribers
         @subscribers = []
         params[:subscriber][:email].split(",").map{|email| 
            subs = Subscriber.new(email: email.strip, status: true)
         
          @subscribers <<  subs if subs.save 
      
         }

        # render partial: "list_subscribers"
    end

    

  end
end
