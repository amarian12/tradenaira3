class PagesController < ApplicationController
  layout 'landing'
  def amlpolicy
  end
  def cookie
  end
  def about
  end
  def fee
  end
  def privacy
  end
  def termsofuse
  end
  def riskwarning
  end
  def news
     @new = New.all
     @feeds = Feed.all   
  end
  def learn
  end
  def tradeservices
  end
  def contactus
  end
  def sendmoney
  end
  def requestmoney
  end
  def faq
  end
  def support
  end

end
