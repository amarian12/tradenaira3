class WelcomeController < ApplicationController
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
end
