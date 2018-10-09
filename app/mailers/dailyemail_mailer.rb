class DailyemailMailer < ActionMailer::Base
  default from: 'news@tradenaira.com'

  def dailymail(member)
    @date = Date.today
    @member = member
    @getusdall = Trade.where(:currency =>'1').pluck(:price)
    @getusdone = @getusdall.last
    @getgbpall = Trade.where(:currency =>'2').pluck(:price)
    @getgbpone = @getgbpall.last
    @geteurall = Trade.where(:currency =>'3').pluck(:price)
    @geteurone = @geteurall.last
    @getcnyall = Trade.where(:currency =>'4').pluck(:price)
    @getcnyone = @getcnyall.last
    @getghsall = Trade.where(:currency =>'6').pluck(:price)
    @getghsone = @getghsall.last

    @getusdbidall = Order.where(:currency =>'1', :type =>'OrderBid').pluck(:price)
    @getusdbidone = @getusdbidall.last
    @getgbpbidall = Order.where(:currency =>'2', :type =>'OrderBid').pluck(:price)
    @getgbpbidone = @getgbpbidall.last
    @geteurbidall = Order.where(:currency =>'3', :type =>'OrderBid').pluck(:price)
    @geteurbidone = @geteurbidall.last
    @getcnybidall = Order.where(:currency =>'4', :type =>'OrderBid').pluck(:price)
    @getcnybidone = @getcnybidall.last
    @getghsbidall = Order.where(:currency =>'6', :type =>'OrderBid').pluck(:price)
    @getghsbidone = @getghsbidall.last

    @getusdaskall = Order.where(:currency =>'1', :type =>'OrderAsk').pluck(:price)
    @getusdaskone = @getusdaskall.last
    @getgbpaskall = Order.where(:currency =>'2', :type =>'OrderAsk').pluck(:price)
    @getgbpaskone = @getgbpaskall.last
    @geteuraskall = Order.where(:currency =>'3', :type =>'OrderAsk').pluck(:price)
    @geteuraskone = @geteuraskall.last
    @getcnyaskall = Order.where(:currency =>'4', :type =>'OrderAsk').pluck(:price)
    @getcnyaskone = @getcnyaskall.last
    @getghsaskall = Order.where(:currency =>'6', :type =>'OrderAsk').pluck(:price)
    @getghsaskone = @getghsaskall.last

	if @getusdone.blank?
       @getusdone = 0.0
	end
	if @getgbpone.blank?
       @getgbpone = 0.0
	end
	if @geteurone.blank?
       @geteurone = 0.0
	end
	if @getcnyone.blank?
       @getcnyone = 0.0
	end

	if @getusdbidone.blank?
       @getusdbidone = 0.0
	end
	if @getgbpbidone.blank?
       @getgbpbidone = 0.0
	end
	if @geteurbidone.blank?
       @geteurbidone = 0.0
	end
	if @getcnybidone.blank?
       @getcnybidone = 0.0
	end

	if @getusdaskone.blank?
       @getusdaskone = 0.0
	end
	if @getgbpaskone.blank?
       @getgbpaskone = 0.0
	end
	if @geteuraskone.blank?
       @geteuraskone = 0.0
	end
	if @getcnyaskone.blank?
       @getcnyaskone = 0.0
	end

  if @getghsaskone.blank?
       @getghsaskone = 0.0
  end

    @membername = IdDocument.find member.id
    @closename = @membername.name
    if @closename.blank?
       @closename = 'user'
	end

    @getrate =  Member.where(:id => member.id).pluck(:dailyrate)
    @getrates =  @getrate.to_json.html_safe

    if @getrates != '["no"]'
	    mail to: member.email, subject: "TradeNAIRA daily rates update #{@date}"
	end

  
  
  end



end
