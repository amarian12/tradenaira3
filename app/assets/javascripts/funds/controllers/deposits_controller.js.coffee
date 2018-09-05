app.controller 'DepositsController', ['$scope', '$stateParams', '$http', '$filter', '$gon', 'fundSourceService', 'ngDialog', ($scope, $stateParams, $http, $filter, $gon, fundSourceService, ngDialog) ->
  
  _selectedFundSourceId = null
  _selectedFundSourceIdInList = (list) ->
    for fs in list
      return true if fs.id is _selectedFundSourceId
    return false
  
  @deposit = {}
  $scope.currency = currency =  $stateParams.currency
  $scope.current_user = current_user = $gon.current_user
  $scope.name = current_user.name
  $scope.fund_sources = $gon.fund_sources
  $scope.account = Account.findBy('currency', $scope.currency)
  $scope.deposit_channel = DepositChannel.findBy('currency', $scope.currency)
  
  $scope.selected_fund_source_id = (newId) ->
    if angular.isDefined(newId)
      _selectedFundSourceId = newId
    else
      _selectedFundSourceId

  $scope.fund_sources = ->

    fund_sources = fundSourceService.filterBy currency:currency
    #alert JSON.stringify(currency)
    # reset selected fundSource after add new one or remove previous one
    if not _selectedFundSourceId or not _selectedFundSourceIdInList(fund_sources)
      $scope.selected_fund_source_id fund_sources[0].id if fund_sources.length
    fund_sources

  # set defaultFundSource as selected
  defaultFundSource = fundSourceService.defaultFundSource currency:currency
  if defaultFundSource
    _selectedFundSourceId = defaultFundSource.id
  else
    fund_sources = $scope.fund_sources()
    _selectedFundSourceId = fund_sources[0].id if fund_sources.length
  
  # set current default fundSource as selected
  $scope.$watch ->
    fundSourceService.defaultFundSource currency:currency
  , (defaultFundSource) ->
    $scope.selected_fund_source_id defaultFundSource.id if defaultFundSource

  @createDeposit = (currency) ->
    $.publish 'flash', {message: "THANK YOU! - We have received your deposit request. Please make payment to our local currency account, you can access it from the link below at any time. Once payment is received your TradeNaira account will be credited." }
    depositCtrl = @
    deposit_channel = DepositChannel.findBy('currency', currency)
    account = deposit_channel.account()

    data = { account_id: account.id, member_id: current_user.id, currency: currency, amount: @deposit.amount, fund_source: _selectedFundSourceId }

    $('.form-submit > input').attr('disabled', 'disabled')

    $http.post("/deposits/#{deposit_channel.resource_name}", { deposit: data})
      .error (responseText) ->
        $.publish 'flash', {message: responseText }
      .finally ->
        depositCtrl.deposit = {}
        $('.form-submit > input').removeAttr('disabled')
        location.reload(true)

  $scope.openFundSourceManagerPanel = ->
    ngDialog.open
      template: '/templates/fund_sources/bank.html'
      controller: 'FundSourcesController'
      className: 'ngdialog-theme-default custom-width'
      data: {currency: $scope.currency}

  $scope.openFundSourceManagerPanelusd = ->
    ngDialog.open
      template: '/templates/fund_sources/usdbank.html'
      controller: 'FundSourcesController'
      className: 'ngdialog-theme-default custom-width'
      data: {currency: $scope.currency}

  $scope.openFundSourceManagerPanelngn = ->
    ngDialog.open
      template: '/templates/fund_sources/ngnbank.html'
      controller: 'FundSourcesController'
      className: 'ngdialog-theme-default custom-width'
      data: {currency: $scope.currency}

  $scope.openFundSourceManagerPanelghs = ->
    ngDialog.open
      template: '/templates/fund_sources/ghsbank.html'
      controller: 'FundSourcesController'
      className: 'ngdialog-theme-default custom-width'
      data: {currency: $scope.currency}    


  $scope.genAddress = (resource_name) ->
    ngDialog.openConfirm
      template: '/templates/shared/confirm_dialog.html'
      data: {content: $filter('t')('funds.deposit_coin.confirm_gen_new_address')}
    .then ->
      $("a#new_address").html('...')
      $("a#new_address").attr('disabled', 'disabled')

      $http.post("/deposits/#{resource_name}/gen_address", {})
        .error (responseText) ->
          $.publish 'flash', {message: responseText }
        .finally ->
          $("a#new_address").html(I18n.t("funds.deposit_coin.new_address"))
          $("a#new_address").attr('disabled', 'disabled')


  $scope.$watch (-> $scope.account.deposit_address), ->
    setTimeout(->
      $.publish 'deposit_address:create'
    , 1000)

]
