module APIKicksmart
  class RewardsController < BaseController
 
  def index
    @rewards = Reward.all
    render :index
  end

  def show

    # @reward = Reward.find(params[:id])
    # render :show
    @reward = Reward.new(reward)
  end

  def edit
    @reward = Reward.find(params[:id])
    render :show
  end

  def create
    @reward = Reward.new(reward_params)

    if @reward.save!
      render :show
    else
      render json: @reward.errors.full_messages, status: 422
    end
  end

  def update
    @reward = Reward.find(params[:id])
    if @reward.update(reward_params)
      render :show
    else
      render json: @reward.errors.full_messages, status: 422
    end
  end

  def destroy
    @reward = Reward.find(params[:id])
    @reward.destroy!
    render :show
  end

  def reward_params
    params.require(:reward).permit(:title, :amount_met, :description, :project_id)
  end
end

end
