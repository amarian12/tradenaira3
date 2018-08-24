class NewsController < ApplicationController
    
    def new
      @new = New.new
    end
    
    def create
      @new = New.new(user_params)
	  if Member.exists?(email: user_params[:email])
		flash[:alert] = "Already exists"
        redirect_to new_news_path
      elsif @new.save
		IddocumentMailer.sendinvite(user_params[:email],root_url,@new.id).deliver
		flash[:notice] = "An invitation email has been sent to the #{user_params[:email]}"
        redirect_to settings_path
      else   
		flash[:alert] = "Email can't be blank or Wrong email"
        redirect_to new_news_path
      end
    end
    
   private

    def user_params
      params.require(:new).permit(:email, :member_id)
    end

end
