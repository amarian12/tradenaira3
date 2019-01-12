module Private
  class FundsController < BaseController
    layout 'funds'

    before_action :auth_activated!
    before_action :auth_verified!
    before_action :two_factor_activated!

    def index
      @title ="Funds"
      @descrip="TradeNAIRA is the only transparent Nigerian Naira Currency Exchange. Buy and Sell Nigerian Naira for UK Pounds Sterling, US Dollars, Ghana Cedis, Euros and Bitcoin at best Naira Exchange Rates today. Send money to Nigeria with the best NGN exchange rates for USD, EUR, BTC, GHC and GBP."
      @keyword ="Tradenaira, Opensource, Exchange, Cryptocurrency"
      @deposit_channels = DepositChannel.all
      @withdraw_channels = WithdrawChannel.all
      @currencies = Currency.all.sort
      @deposits = current_user.deposits
      @accounts = current_user.accounts.enabled
      @withdraws = current_user.withdraws
      @fund_sources = current_user.fund_sources
      @banks = Bank.all
      @ngnbanks = Bank.all

      accounts = []
       
      cids =  Currency.all.sort_by { |k| k[:owait] }.map{|c| c.id }
      cids.map{|c| 
        account =  @accounts.find_by_currency(c)
        #create the account if its not exists
        if account.nil?
         account = current_user.accounts.create(currency: c, balance: 0.0, locked: 0.0) 
        end
        accounts << account
      }

      @accounts = accounts

      gon.jbuilder
    
    end

    def gen_address
      current_user.accounts.each do |account|
        unless account.currency_obj.nil?
            next if not account.currency_obj.coin?
            if account.payment_addresses.blank?
              account.payment_addresses.create(currency: account.currency)
            else
              address = account.payment_addresses.last
              address.gen_address if address.address.blank?
            end
        end
      end
      render nothing: true
    end
   def transfer
   end 

  end
end

