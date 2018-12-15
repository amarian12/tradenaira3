module Admin
  	class MetasController < BaseController


 		def list_category
 			@cats = MetaCategory.all
 		end

 		def new_category
 			@cat = MetaCategory.new
 		end

 		def edit
 			@type = params[:type]
 			@id = params[:id]

 			if @type == "category"
 			 	@cat = MetaCategory.find_by_id(@id)
 			elsif @type == "content"
 			 	@content = MetaContent.find_by_id(@id)
 			end

 		end

 		def update
 			@type = params[:type]
 			@id = params[:id]

 			if @type == "category"
 			 	@cat = MetaCategory.find_by_id(@id)
 			 	if @cat.update(category_params)
 			 		flash[:notice] = "Success"
 					redirect_to admin_list_category_path
 					return false
 			 	end
 			elsif @type == "content"
 			 	@content = MetaContent.find_by_id(@id)
 			 	if @content.update(content_params)
 			 		flash[:notice] = "Success"
 					redirect_to admin_list_content_path
 					return false
 			 	end
 			end
 			
 		end

 		def create_category
 			@cat = MetaCategory.new category_params
 			if @cat.save
 				flash[:notice] = "Success"
 				redirect_to admin_list_category_path
 			else
 				render :new_category
 			end
 		end
 	  	
 	   
	  	def list_content
	  		@contents = MetaContent.all
	  	end

	  	def new_content
	  		@content = MetaContent.new
	  	end

	  	def create_content
 			@content = MetaContent.new content_params
 			if @content.save
 				flash[:notice] = "Success"
 				redirect_to admin_list_content_path
 			else
 				render :new_content
 			end
 		end


 		def destroy
 			type = params[:type]
 			id = params[:id]

 			if type == "category"
 			 	meta = MetaCategory.find_by_id(id)
 			elsif type == "content"
 			 	meta = MetaContent.find_by_id(id)
 			end

 			if meta
 				meta.destroy
 				flash[:notice] = "Success"
 				redirect_to :back
 			else
 				flash[:error] = "Faild"
 				redirect_to :back
 			end
 			
 		end

	  	private


	  	def category_params
	  		params.require(:meta_category).permit(:title,:parent_id)
	  	end

	  	def content_params
	  		params.require(:meta_content).permit(:title,:description, :meta_category_id)
	  	end

	end

end
