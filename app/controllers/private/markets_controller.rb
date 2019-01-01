module Private
  class MarketsController < BaseController
    skip_before_action :auth_member!, only: [:show]
    before_action :visible_market?
    after_action :set_default_market

    layout false

    def show
      @bid = params[:bid]
      @ask = params[:ask]

      @market        = current_market
      @markets       = Market.all.sort
      @market_groups = @markets.map(&:quote_unit).uniq
      

      @bids   = @market.bids
      @asks   = @market.asks
      @trades = @market.trades

      # default to limit order
      @order_bid = OrderBid.new ord_type: 'limit'
      @order_ask = OrderAsk.new ord_type: 'limit'

      if params[:market] == "usdngn"
        @title = "United States Dollars (USD) and Nigerian Naira (NGN)"
        @description = "Convert US Dollar USD to Nigerian Naira NGN with our currency exchange at TradeNAIRA. Get real time naira dollar exchange rates and buy Nairas online today as well as get ₦ live data. Transfer money from United States of America to Nigeria quickly or send Naira to the USA"
      elsif params[:market] == "gbpngn"
         @title = "Exchange Pounds Sterling (GBP) and Nigerian Naira (NGN)"
         @description = "Convert Pounds Sterling GBP to Nigerian Naira NGN with our currency exchange at TradeNAIRA. Get real time pound naira exchange rates and buy Nairas online today as well as get ₦ live data. Transfer money from London to Nigeria quickly or send Naira to the UK."
      elsif params[:market] == "ghsngn"
          @title = "Exchange Nigerian Naira (NGN) and Ghanaian Cedis (GHS)"
          @description = "Convert Nigerian Naira NGN to Ghanaian Cedis GHS with our currency exchange at TradeNAIRA. Get real time cedi naira exchange rates and buy Nairas online today as well as get ₦ live data. Transfer money from Ghana to Nigeria quickly or send Naira to the Ghana."
     elsif params[:market] == "usdghs"
          @title = "Exchange United States Dollars (USD) and Ghanaian Cedis (GHS)"
          @description = "Convert US Dollar USD to Ghanaian Cedis GHS with our currency exchange at TradeNAIRA. Get real time dollar cedi exchange rates and buy Ghana Cedi online today as well as get GH₵ live data. Transfer money from America to Ghana quickly or send Cedis to the USA."
     elsif params[:market] == "btcngn"
          @title = "Bitcoin Exchange in Nigeria; Buy Bitcoin with Naira"
          @description = "Buy, sell and margin trade Bitcoin (BTC) and Naira (NGN) with TradeNAIRA, the premier Nigerian Bitcoin cryptocurrency exchange, get the best Naira / Bitcoin Exchange rates. The number 1 digital currency exchange in Nigeria - ₦ (naira sign)."
    elsif params[:market] == "btcusd"
          @title = "Bitcoin Exchange in Nigeria; Buy Bitcoin with USD"
          @description = "Buy, sell and margin trade Bitcoin (BTC) and US dollars (USD) with TradeNAIRA, the premier Bitcoin cryptocurrency exchange, get the best Bitcoin Dollar Exchange rates. The number 1 digital currency exchange in Nigeria - $ (dollar sign)."
     elsif params[:market] == "btcgbp"
          @title = "Bitcoin Exchange in Nigeria; Buy Bitcoin with GBP"
          @description = "Buy, sell and margin trade Bitcoin (BTC) and British Pounds (GBP) with TradeNAIRA, the premier Bitcoin cryptocurrency exchange, get the best Bitcoin Pounds Exchange rates. The number 1 digital currency exchange in Nigeria - £ (pound sign). "
     elsif params[:market] == "gbpghs"
          @title = "Exchange Pounds Sterling (GBP) and Ghanaian Cedis (GHS)"
          @description = "Convert Pounds Sterling GBP to Ghanaian Cedis GHS with our currency exchange at TradeNAIRA. Get real time pound cedi exchange rates and buy Ghana Cedi online today as well as get GH₵ live data. Transfer money from London to Ghana quickly or send Cedis to the UK."
    elsif params[:market] == "btcghs"
          @title = "Bitcoin Exchange in Ghana; Buy Bitcoin with Ghana Cedis GHS "
        @description = "Buy, sell and margin trade Bitcoin (BTC) and Ghanaian Cedis (GHS) with TradeNAIRA, the premier Bitcoin cryptocurrency exchange, get the best Bitcoin Cedi Exchange rates. The number 1 digital currency exchange in Ghana GH₵."
    else
    end


      set_member_data if current_user
      gon.jbuilder
      
    end

    private

    def visible_market?
      redirect_to market_path(Market.first) if not current_market.visible?
    end

    def set_default_market
      cookies[:market_id] = @market.id
    end

    def set_member_data
      @member = current_user
      @orders_wait = @member.orders.with_currency(@market).with_state(:wait)
      @trades_done = Trade.for_member(@market.id, current_user, limit: 100, order: 'id desc')
    end

  end
end
