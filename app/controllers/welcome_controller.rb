class WelcomeController < ApplicationController
  before_action :set_metatags
  
  layout 'landing'

  def index
    start_at = DateTime.now.ago(60 * 60 * 48)
    @countslide = Slider.all
    @usdslider = Slider.where("usdtxt is NOT NULL and usdtxt != ''").find(:all,:select => 'usdtxt')
    @usdarray = Slider.where("usdtxt is NOT NULL and usdtxt != ''").pluck(:usdtxt)
    @poundslider = Slider.where("poundtxt is NOT NULL and poundtxt != ''").find(:all,:select => 'poundtxt')
    @poundarray = Slider.where("poundtxt is NOT NULL and poundtxt != ''").pluck(:poundtxt)
    @euroslider = Slider.where("eurotxt is NOT NULL and eurotxt != ''").find(:all,:select => 'eurotxt')
    @euroarray = Slider.where("eurotxt is NOT NULL and eurotxt != ''").pluck(:eurotxt)
    #@feeds = Feed.find(:all, :order => "id desc", :limit => 1)
    #User.invite!(:email => "msk@cogzidel.com")
    
  end

  def advertise
  end

  def contact
   @user = Member.new(member_params)
   errors = false
   success = false 
    if verify_recaptcha(model: @user)
        if @user.valid?
          success = true
          MemberMailer.contact_mail(@user).deliver
        else
            errors = @user.errors
            success = false
        end
    else
      errors = {captcha: "Invalid captcha please try again!"}
    end
   response = { success: success, errors: errors }
   respond_to do |format|
     format.json { render json: response }
   end
  end

  private
  def member_params
    params.required(:member).permit(:email, :display_name, :last_name,
      :phone_number, :business, :business_address, :nonsensefor)
  end
end
