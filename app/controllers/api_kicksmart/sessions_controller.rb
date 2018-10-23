module APIKicksmart
	class SessionsController < BaseController
		skip_load_and_authorize_resource

	  def create
	    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

	    

	    if @user
	      login(@user)
	      render "api/users/show"
	    else
	      render json: ["Invalid username or password"], status: 401
	    end
	  end

	  def destroy
	    if logged_in?
	      logout
	    else
	      render json: ["No user currently signed in"]
	    end
	  end
	end
end




