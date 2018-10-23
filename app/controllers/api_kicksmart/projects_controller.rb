module APIKicksmart
  class ProjectsController < BaseController
 
  def index
    @projects = Project.all
    render :index
  end

  def show
    @project = Project.find(params[:id])
    render :show
  end

  def edit
    @project = Project.find(params[:id])
    render :show
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id

    if @project.save!
      render :show
    else
      render json: @project.errors.full_messages, status: 422
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      render :show
    else
      render json: @project.errors.full_messages, status: 422
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy!
    render :show
  end

  def project_params
    params.require(:project).permit(:title, :blurb, :description, :end_date, :funding_goal, :image_url, :category_id, :author, :total_amount)
  end
end

end
