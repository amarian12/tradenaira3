#module Blogo

class Blogo::Admin::BannersController < Blogo::ApplicationController
  before_action :set_metatags
  before_action :set_category, only: [:index,:new]
  before_filter :sanitize_page_params, only: [:create, :update]
  layout 'blogo/blog'
  
  

  

  before_action :set_blogo_banner, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @blogo_banners = Blogo::Banner.send(@category.to_sym)
    respond_with(@blogo_banners)
  end

  def show
    respond_with(@blogo_banner)
  end

  def new
    @blogo_banner = Blogo::Banner.new(category: @category)
    respond_with(@blogo_banner)
  end

  def edit
  end

  def create

    puts blogo_banner_params.inspect

    @blogo_banner = Blogo::Banner.new(blogo_banner_params)



    if @blogo_banner.save
      flash[:notice] = 'Blogo::Banner was successfully created.' 
      redirect_to list_blogo_admin_banners_path(@blogo_banner.category)
      return false
    end

    

    respond_with(@blogo_banner)
  end

  def update
    flash[:notice] = 'Blogo::Banner was successfully updated.' if @blogo_banner.update(blogo_banner_params)
    respond_with(@blogo_banner)
  end

  def destroy
    @blogo_banner.destroy
    respond_with(@blogo_banner)
  end

  private
    def set_blogo_banner
      @blogo_banner = Blogo::Banner.find(params[:id])
    end

    def blogo_banner_params
      params.require(:banner).permit(:title, :image, :category)
    end

    def set_metatags

      @meta = {}
      @meta[:title]       = ""
      @meta[:description] = ""
      @meta[:keywords]    = ""
      @meta[:url]         = ""
      @meta[:image]       = ""
      @meta[:type]        = ""
      @meta[:site_name]   = ""
      
    end

    def set_category
      @category = params[:category]
    end


    def sanitize_page_params
      params[:banner][:category] = params[:banner][:category].to_i
    end


end

#end
