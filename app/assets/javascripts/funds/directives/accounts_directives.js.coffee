app.directive 'accounts', ->
  return {
    restrict: 'E'
    templateUrl: '/templates/funds/accounts.html'
    scope: { localValue: '=accounts' }
    controller: ($scope, $state) ->
      ctrl = @
      @state = $state

       

      if window.location.hash == "" || window.location.hash == "#/transfer"
        @state.transitionTo("deposits.currency", {currency: Account.first().currency})
        if window.location.hash == "#/transfer"
          setTimeout (->
            #$('#transfer-contaer').show 0
            return
          ), 2000
          
          

      $scope.accounts = Account.all()

      # Might have a better way
      # #/deposits/cny
      @selectedCurrency = window.location.hash.split('/')[2] || Account.first().currency
      @currentAction = window.location.hash.split('/')[1] || 'deposits'
      $scope.currency = @selectedCurrency

      @isSelected = (currency) ->
        @selectedCurrency == currency

      @isDeposit = ->
        @currentAction == 'deposits'

      @isWithdraw = ->
        @currentAction == 'withdraws'

      @deposit = (account) ->
        ctrl.state.transitionTo("deposits.currency", {currency: account.currency})
        ctrl.selectedCurrency = account.currency
        ctrl.currentAction = "deposits"

      @withdraw = (account) ->
        ctrl.state.transitionTo("withdraws.currency", {currency: account.currency})
        ctrl.selectedCurrency = account.currency
        ctrl.currentAction = "withdraws"

      @openTransferPage = (accounts) ->
        window.location.hash = "transfer"
        #$("#transfer-contaer").show(0)
         
        #ctrl.currentAction = "transfer"

         

      do @event = ->
        Account.bind "create update destroy", ->
          $scope.$apply()

    controllerAs: 'accountsCtrl'
  }

