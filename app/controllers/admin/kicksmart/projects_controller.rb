module Admin
  module Kicksmart

class ProjectsController < BaseController
  before_action :set_project, only: [:edit, :destroy, :update, :show]
  def index
    @projects = Project.all
  end

  def show
  end


  def create
    @url = admin_kicksmart_projects_path
    @project = Project.new(project_params)
    if @project.save
      update_categories
      redirect_to admin_kicksmart_project_path(@project) 
    else
      render :new
    end
  end

  def new
    @project = Project.new
    @url = admin_kicksmart_projects_path
  end

  def edit
    @url = admin_kicksmart_project_path(@project)
  end

  def update
    @url = admin_kicksmart_project_path(@project)

    if @project.update(project_params)
      update_categories
     redirect_to admin_kicksmart_project_path(@project)   
    else
        render :edit
    end



    
  end

  def destroy
    @project.destroy
     redirect_to admin_kicksmart_projects_path
  end

  private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :blurb, :description, 
      :image_url, :end_date, :funding_goal, :author, :total_amount)
  end


  def update_categories
        cats_all      = @project.categories.pluck(:id)
        cate_current  = params[:project][:categories]

        cats_add = cate_current - cats_all
        cate_del = cats_all - cate_current

        if cate_del.present?
          cate_del.map{|c|
            cate = Category.find_by_id(c)
            @project.categories.destroy(cate)
          }
          
        end

        if cats_add.present?
          cats_add.map{|c|
            cate = Category.find_by_id(c)
            unless cate.nil?
              @project.categories << cate
            end
          }
        end
  end
   

end

end
end
