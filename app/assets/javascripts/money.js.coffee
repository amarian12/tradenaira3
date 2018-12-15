#= require jquery
#= require ./lib/tiny-pubsub
#= require pusher.min
#= require angular
#= require angular-resource
#= require bootstrap
#= require ./lib/angular-ui-router



@money =  angular.module 'money', ["ui.router", "ngResource"]
@money.controller 'MoneyController', ($scope, $stateParams, $http) ->

	ctrl = @
	$scope.page_title = "Select the type of transaction"
	$scope.page_index = 1

	$selected_trans_type = 1
	$selected_trans_role = 1
	$scope.resp = ""

	$http.get("/money/escrow.json")
	  .success (resp)->
	    $scope.resp = resp
	    console.log(resp)

	$scope.nextStep = ->
	  $scope.page_index = 2
	  $scope.page_title = "Escrow money"

	$scope.moveonStep = (step)->
	  if step == 1
	    $scope.page_title = "Select the type of transaction"
	    $scope.page_index = 1
	  else if step == 2
	    $scope.page_title = "Escrow money"
	    $scope.page_index = 2

#ctrl ended 
 
@money.config ($stateProvider, $urlRouterProvider) -> 
	if window.location.hash == "" 
	  window.location.hash = "#/index"
	  #alert(window.location.hash)

	$stateProvider
		.state('otherwise', {
      		url: '/',
      		templateUrl: "/templates/money/escrow.html",
      		controller: 'MoneyController'
    	})
		.state('index', {
      		url: '/index',
      		templateUrl: "/templates/money/escrow.html",
      		controller: 'MoneyController'
    	})
    	.state('seller', {
      		url: '/seller',
      		templateUrl: "/templates/money/seller.html",
      		controller: ''
    	})
    	 
		 
 


