class DailyemailMailer < ActionMailer::Base
  default from: 'news@tradenaira.com'

  def dailymail(member)
    @date = Date.today
    @recent_posts = Blogo::Post.published.limit(2)
    @member = member

    @trades_all = []
     
    msymbols    = ["usdngn","gbpngn","ghsngn","usdghs", "btcngn", 
      "btcusd", "btcgbp", "gbpghs","btcghs", "eurngn"]

    id = 0  
    msymbols.each do |sm|
      id = id + 1
      trades    = Trade.where(:currency =>"#{id}").pluck(:price)
      trade     = trades.last

      bidall    = Order.where(:currency =>"#{id}", :type =>'OrderBid').pluck(:price)
      bid_one   = bidall.last

      ask_all   = Order.where(:currency =>"#{id}", :type =>'OrderAsk').pluck(:price)
      ask_one   = ask_all.last

      trade   = trade.nil? ? 0.0 : trade
      bid_one = bid_one.nil? ? 0.0 : bid_one
      ask_one = ask_one.nil? ? 0.0 : ask_one


      market = { 
        mname:    sm,
        trade:    trade,
        bid_one:  bid_one,
        ask_one:  ask_one
      }

      @trades_all << market
    end
    
    #@membername = IdDocument.find member.id
    @closename = @member.name
    if @closename.blank?
       @closename = 'user'
	end

    @getrate =  Member.where(:email => member.email).pluck(:dailyrate)
    @getrates =  @getrate.to_json.html_safe

    if @getrates != '["no"]'
	    mail to: member.email, subject: "TradeNAIRA daily rates update #{@date}"
	end

  
  
  end



end
