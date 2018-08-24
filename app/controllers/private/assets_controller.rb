module Private
  class AssetsController < BaseController
    skip_before_action :auth_member!, only: [:index]

    def index
      @cny_assets  = Currency.assets('cny')
      @ngn_assets  = Currency.assets('ngn')
      @usd_assets  = Currency.assets('usd')
      @eur_assets  = Currency.assets('eur')
      @gbp_assets  = Currency.assets('gbp')
      @btc_assets  = Currency.assets('btc')

      @ghs_assets  = Currency.assets('ghs')

      @cny_proof   = Proof.current :cny
      @ngn_proof   = Proof.current :ngn
      @usd_proof   = Proof.current :usd
      @eur_proof   = Proof.current :eur
      @gbp_proof   = Proof.current :gbp
      @btc_proof   = Proof.current :btc

      @ghs_proof   = Proof.current :ghs

      if current_user
        @cny_account = current_user.accounts.with_currency(:cny).first
        @ngn_account = current_user.accounts.with_currency(:ngn).first
        @usd_account = current_user.accounts.with_currency(:usd).first
        @eur_account = current_user.accounts.with_currency(:eur).first
        @gbp_account = current_user.accounts.with_currency(:gbp).first
        @btc_account = current_user.accounts.with_currency(:btc).first
        @ghs_account = current_user.accounts.with_currency(:ghs).first
      end
    end

    def partial_tree
      account    = current_user.accounts.with_currency(params[:id]).first
      @timestamp = Proof.with_currency(params[:id]).last.timestamp
      @json      = account.partial_tree.to_json.html_safe
      respond_to do |format|
        format.js
      end
    end

  end
end
