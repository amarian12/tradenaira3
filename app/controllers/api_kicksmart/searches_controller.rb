module APIKicksmart
  class SearchesController < BaseController
 
  def index
    @projects = Project.search_results(search_params[:query])
    render :index
  end

  def random_project
    @project = Project.all.sample
    render 'api/projects/show'
  end

  def search_params
    params.require(:search).permit(:query, :project_id)
  end
end

end
