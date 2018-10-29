class MoneyController < ApplicationController
  def req
  end
  def req_success
  end
  def commission
  end

  def send_money
  	if params[:member]
  		resp = { msg: "Still working" }
  		render json: resp
  	end
  end
end
