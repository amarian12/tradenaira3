#= require jquery
#= require ./lib/tiny-pubsub
#= require pusher.min
#= require angular
#= require angular-resource
#= require bootstrap
#= require ./lib/angular-ui-router



@money =  angular.module 'money', ["ui.router", "ngResource"]
@money.controller 'MoneyController', ($scope, $stateParams, $http, $sce) ->

	ctrl = @
	$scope.page_title = "Select the type of transaction"
	$scope.page_index = 1
	$scope.is_valid = true

	$selected_trans_type = 1
	$selected_trans_role = 1
	$scope.resp = ""
	$scope.transaction = {
		type: "",
		role: "",
		phone:""
	}
	$scope.errors = {
		role: "",
		type: ""
	}
	$scope.currecy_image = ""

	$http.get("/money/escrow.json")
	  .success (resp)->
	    $scope.resp = resp
	    $scope.moveonStep(1,false)
	    console.log(resp)

	$scope.selectCurrecy = (account)->
	  $scope.transaction.account = account
	  $scope.currecy_image = $sce.trustAsHtml('<img src="/icon-'+account.currency+'.png" />')
	    

	 
	  #alert(JSON.stringify($scope.transaction))

	$scope.moveonStep = (step,validate)->
	  $scope.errors = { role: "", type: "" }
	  $scope.is_valid = true
		 

	  if step == 1
	    $scope.page_title = "Select the type of transaction"
	    $scope.page_index = 1


	  else if step == 2
	    if validate
	      if $scope.transaction.type == ""
	        $scope.errors.type 	= "Please Select the type of transaction!"
	        $scope.is_valid 	= false
	      if $scope.transaction.role == ""
	        $scope.errors.role 	= "Please Select the role"
	        $scope.is_valid 	= false

	    if $scope.is_valid    
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
    	 
		 
 


