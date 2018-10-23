module APIKicksmart
  class LikesController < BaseController

 
  def create
    @like = Like.new

    @like.project_id = params[:project_id]
    if @like.save!
      @project = @like.project
      render 'api/projects/show'
    else
      render json: @like.errors.full_messages, status: 422
    end
  end

  def destroy
    @like = Like.find_by(project_id: params[:id])
    @project = @like.project

    if @like
      @like.destroy!
      render 'api/projects/show'
    else
      render json:["where"], status: 400
    end
  end
end

end
