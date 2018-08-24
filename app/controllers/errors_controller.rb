class ErrorsController < ApplicationController
 def not_found
   render status: 404
  end

  def server_error
    render status: 500
  end
 
  def routing
    redirect_to root_path
  end
end
