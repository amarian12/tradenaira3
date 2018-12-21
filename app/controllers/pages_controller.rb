class PagesController < ApplicationController
  before_action :set_metatags
  layout 'landing'
  def amlpolicy
    @title    = "TradeNAIRA anti-money laundering policy "
    @descrip  = "at TradeNAIRA, we take money laundering very seriously and will take all appropriate steps to inform the relevant authorities and close suspected accounts if we believe that is being used for illicit purposes."
  end

  def cookie
    @title    = "TradeNAIRA Cookies"
    @descrip  = "We may use cookies in order to make you browsing experience better and make sure you get information and data that is relevant to you. "
  end
  def about
   @title = "TradeNAIRA is an online company focused on making business in Nigeria easy!"
   @descrip = "We want to be the biggest business gateway to Nigeria and West Africa and have a host of services aimed at the Nigerian business community to add trust and create value amongst all members."
  end
  def fee
    @title    = "TradeNAIRA fees"
    @descrip  = "Costs associated with using TradeNAIRA vary depending on the service you require. Our primary service is the currency exchange which is a peer to peer exchange system and we charge a small fee for matching transactions. ."
  end

  def projectfunding
  end

  def srnoti
    #first update the visitor counter
    update_visitor_counter

    unless current_user.nil?
        if params[:task] == "load"
          msgs = current_user.sr_notofications
          active_count = msgs.where(status: false).count
          msgsresp = []

          msgs.order(created_at: :desc).map{|n| 
            ddif = TimeDifference.between(DateTime.now, n.created_at).humanize
            msgsresp << { id: n.id, msg: n.msg, link_page: n.link_page,
              created_at: n.created_at, status: n.status, ddif: ddif   }
          }

          resp = { success: true, msgs: msgsresp, active_count: active_count    }
          
        elsif params[:task] == "clear"
           msgs = current_user.sr_notofications.map{|n| 
            n.status = true 
            n.save
          } 
          resp = { success: true, msgs: msgs  }   
        end
    else    
      resp = { success: false, msgs: ""  }
    end

     
    render json: resp

  end

  def privacy
    @title    = "TradeNAIRA user privacy"
    @descrip  =  "at TradeNAIRA we take user privacy very seriously, all data is heavily encrypted and we will only contact you if you have requested to be on our mailing list or use our services."
  end
  def termsofuse
    @title    = "TradeNAIRA Terms of Use"
    @descrip  = "if using TradeNAIRA you agree to our terms of use."
  end
  def riskwarning
    @title    = "TradeNAIRA risk warning"
    @descrip  = "TradeNAIRA’s exchange is fully dictated by you. We must warn that our platform was not built for speculation and is intended for individuals and businesses trading with each other for currency that they need for commercial or personal reasons."
  end
  def news
     @new = New.all
     @feeds = Feed.all   
  end
  def liveprice
    response.headers["X-FRAME-OPTIONS"] = "ALLOWALL"
    @market = params[:market]
    render "liveprice", layout: false
  end
  def learn
    @title    = "Nigerian and Naira Business Data and Statistics - TradeNAIRA"
    @descrip  = "Browse through Nigeria trade statistics and other relevant data to enable you to make more informed business decisions in Nigeria. Read our Guide to doing business in Nigeria."
  end
  def tradeservices
    @title = "Professional & Trusted Business Services for Nigeria and West Africa"
    @descrip = "TradeNAIRA offers Nigeria’s premier escrow and business facilitation services, offering trade services such as trade finance to secure payments, business registration and accounting services to foreign companies trading in Nigeria."
  end
  def contactus
    @title    = "How to contact TradeNAIRA"
    @descrip  = "Contact TradeNAIRA for business enquiries or to find out about our services and future plans. Follow us on twitter and facebook for real time updates and information relating to business in Nigeria and West Africa."
  end
  def sendmoney
    unless current_user.nil?
      @deposit_channels = DepositChannel.all
      @withdraw_channels = WithdrawChannel.all
      @currencies = Currency.all.sort
      @deposits = current_user.deposits
      @accounts = current_user.accounts.enabled
      @withdraws = current_user.withdraws
      @fund_sources = current_user.fund_sources
      @banks = Bank.all
      @ngnbanks = Bank.all
      gon.jbuilder
    end
    
      @title = "Send money to Nigeria"
      @descrip = "Send money to Nigeria with our online money transfer services. Transfer money to Nigeria safely to arrive same day, within minutes. We make sending money cheap and easy. "
  end
  def requestmoney
    @title    = "TradeNAIRA Payment Request – send an invoice to a customer in Nigeria."
    @descrip  = "Get paid fast by making a payment request from your customers in Nigeria. Invoice your customer for free and we can collect your payment on your behalf, let be your Nigerian paypal."
  end

  def faq
    @title    = "TradeNAIRA frequently asked questions"
    @descrip  = "find out everything you need to know about TradeNAIRA and our currency exchange services we are an Africa focused business. "
  end
  def support
    @title    = "TradeNAIRA Support"
    @descrip  = "Get in touch with TradeNAIRA today and discover how easy it is to do business in Nigeria, Ghana and West Africa."
     
  end

  def subscribe
    subs_fields = params.required(:subscriber).permit(:email, :name)
    subscr = Subscriber.new(subs_fields)
    success = false
    errors = false
    msg = ""
     
    if subscr.save
      msg = "Thanks for subscribing our newsletter."
      success = true
      errors = false
    else
      msg = "There was some errors while processing your request: "
      success = false
      errors = subscr.errors.messages
    end


    resp = { success: success, errors: errors, msg: msg }

    respond_to do |format| 
      format.json { render json: resp }
    end   

  end


  def unsubscribe
    email = CGI.unescape(params[:email]).gsub("*",".")
    @subscriber = Subscriber.find_by_email(email)
      @msg = "Something went wrong, Please try again!"
      unless @subscriber.nil?
        @subscriber.status = false
        @subscriber.save(validate: false)
         @msg = "Your email was unsubscribed successfully, 
         hopefully you will back one day! good luck."
      end
    
  end

 

end
