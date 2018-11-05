module Admin
	module Kicksmart

class CategoriesController < BaseController
	before_action :set_category, only:[:edit, :update, :destroy]

  def index
  	@categories = Category.all
  end

 def new
 	@category = Category.new 
 	@url = admin_kicksmart_categories_path
 end

  def edit
  	@url = admin_kicksmart_category_path(@category)
  end

  def create
  	@url = admin_kicksmart_categories_path
  	@category = Category.new(name: params[:category][:name]) 
  	if @category.save
  		redirect_to admin_kicksmart_categories_path
  	else
  		render "new"
  	end
  end

  def update
  	@url = admin_kicksmart_category_path(@category)

  	@category.name = params[:category][:name] 
  	if @category.save
  		redirect_to admin_kicksmart_categories_path
  	else
  		render "edit"
  	end
  	
  end

  def destroy
  	@category.destroy
  	redirect_to admin_kicksmart_categories_path
  end


  private

  def set_category
  	@category = Category.find_by_id(params[:id])
  end

  
end

end
end
