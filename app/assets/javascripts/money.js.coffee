#= require jquery
#= require ./lib/tiny-pubsub
#= require pusher.min
#= require angular
#= require angular-resource
#= require bootstrap
#= require bootstrap-datepicker
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
	
	$scope.currecy_image = ""
	$scope.shipping_currecy_image = ""

	$scope.transaction = 
	  email: ''
	  type: ''
	  role: ''
	  phone: ''
	  currency: ''
	  amount: ''
	  item_name: ''
	  shipping_currency: ''
	  shipping_amount: ''
	  fee_payer: ''
	  inspection_length: ''
	  descriptions: ''

	$scope.intializeVars = ->
	  $scope.errors = 
	    email: ''
	    type: ''
	    role: ''
	    phone: ''
	    currency: ''
	    amount: ''
	    item_name: ''
	    shipping_currency: ''
	    shipping_amount: ''
	    fee_payer: ''
	    inspection_length: ''
	    descriptions: ''

	$scope.intializeVars()	


	$scope.dateDiff = (startD, endD)->
	  #'2017-10-01';
	  timeDiff  =  (new Date(endD)) - startD;
	  days      =  timeDiff / (1000 * 60 * 60 * 24)
	  if days < 0
	    days = 0
	  else if days > 0 && days < 1
	    days = 1
	  else 
	    days = parseInt(days)+1   
	  return days

	$http.get("/money/escrow.json")
	  .success (resp)->
	    $scope.resp = resp
	    $scope.moveonStep(1,false)
	    console.log(resp)

	$scope.loadDatePicker = ()->  
	  d = new Date
	  $('input.datepicker').datepicker(format: 'yyyy-mm-dd', maxDate: 0, startDate: d, autoclose: true)
	  .change (option)->
	    selectd = $(this).val()
	    $scope.diff 	= $scope.dateDiff(d,selectd)
	    $scope.days_str = " day" 
	    if $scope.diff > 1
	      $scope.days_str = " days"
	    setTimeout (->
	    	ddiff = ($scope.diff + $scope.days_str)
	    	$scope.transaction.inspection_length = ddiff
	    	$("#tn-inspection-length").val(ddiff)
	    	return false
	    	), 1

	    return false
	  return false


	$scope.selectCurrecy = ()->
	  currency = $scope.transaction.currency
	  if currency == ""
	    $scope.currecy_image = ""
	  else
	    $scope.currecy_image = $sce.trustAsHtml('<img src="/icon-'+currency+'.png" />')

	$scope.selectShippingCu = ->
	  currency = $scope.transaction.shipping_currency
	  if currency == ""
	    $scope.shipping_currecy_image = ""
	  else  
	    $scope.shipping_currecy_image = $sce.trustAsHtml('<img src="/icon-'+currency+'.png" />')

	 
	  #alert(JSON.stringify($scope.transaction))

	$scope.moveonStep = (step,validate)->
	  $scope.intializeVars()
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
	      if $scope.transaction.role == "seller" 
	      	$scope.loadDatePicker()
	  else if step == 3  
	    $scope.doSubmitSeller(true)	
	  return      	

    #Seller function
	$scope.doSubmitSeller = (validate)->
	  if validate
	    if $scope.transaction.email == ""
	      $scope.errors.email = "Please fill the email address" 
	    email_pattern = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/  

	    if email_pattern.test($scope.transaction.email)
	    else
	      $scope.errors.email = "Please fill the valid email address" 

	    $scope.transaction.phone
	    pattern = /^[0-9-+]+$/
	    plenth = $scope.transaction.phone.length
	    if plenth > 0
	      if (pattern.test($scope.transaction.phone) && plenth >9 && plenth <14) 
	      else
	        $scope.errors.phone = "Invalid Phone number"

	    if $scope.transaction.currency == ""
	      $scope.errors.currency = "Please select the currency"   

	    if $scope.transaction.amount == ""  
	      $scope.errors.amount = "Please fill the amount"
	    if $scope.transaction.amount > 0
	    else
	      $scope.errors.amount = "Please fill the valid amount"

	    if $scope.transaction.item_name == ""
	      $scope.errors.item_name = "Please fill, what are you buying?"

	    if $scope.transaction.fee_payer == "" 
	      $scope.errors.fee_payer = "Please select, who will pay the fee?"

	    if $scope.transaction.shipping_currency == "" 
	      $scope.errors.shipping_currency = "Please select, shipping currency" 

	    if $scope.transaction.shipping_amount == "" 
	      $scope.errors.shipping_amount = "Please select, shipping amount"   

	    if $scope.transaction.shipping_amount > 0  
	    else  
	      $scope.errors.shipping_amount = "Please fill, valid shipping amount"  

	    if $scope.transaction.inspection_length == ""  
	      $scope.errors.inspection_length = "Please fill, inspection duration"  

	    if $scope.transaction.descriptions == ""  
	      $scope.errors.descriptions = "Please fill, shor descriptions about this escro."   



	  
	      
	       
	            
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
    	 
		 
 


$(document).ready ->
  d = new Date
   
  $('input.datepicker').datepicker(
    format: 'mm-dd-yyyy'
    maxDate: 0
    endDate: d
    autoclose: true).change ->
    t = $(this).data('target')
    if typeof t == 'undefined'
      $('.searchbydate').data t, $(this).val()
    return
  return

 