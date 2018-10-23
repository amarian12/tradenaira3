module APIKicksmart
  class PledgesController < BaseController
 
  def create

    @pledge = Pledge.new(pledge_params)

    @pledge.user_id = current_user.id
    @pledge.project_id = params[:project_id]
    @pledge.reward_id = params[:reward_id]

    if @pledge.save
      render :show
    else
      render json: @project.errors.full_messages, status: 422
    end
  end

  def pledge_params
    params.require(:pledge).permit(:amount_pledged)
  end
end

end
