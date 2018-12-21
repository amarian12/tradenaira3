#= require jquery
#= require ./lib/tiny-pubsub
#= require pusher.min
#= require angular
#= require angular-resource
#= require bootstrap
#= require bootstrap-datepicker
#= require ./lib/angular-ui-router
#= require_tree ./funds/filters



@money =  angular.module 'money', ["ui.router", "ngResource", "translateFilters"]
@money.controller 'MoneyController', ($scope, $stateParams, $http, $sce) ->

	ctrl = @
	$scope.page_title = "Select the type of transaction"
	$scope.page_index = 1
	$scope.is_valid = true

	$selected_trans_type = 1
	$selected_trans_role = 1
	$scope.resp = ""
	$scope.is_page_loading = true
	$scope.two_fetor_error = false
	$scope.twofactor_html = ""

	$scope.current_user = current_user =  ""
	
	$scope.currecy_image = ""
	$scope.shipping_currecy_image = ""

	$scope.auth = {
		google_app: "google", 
		sms: "sms", 
		hints: { app: "app", sms: "sms" }, 
		send_code: "send_code"
	}

	$scope.transaction = 
	  seller_email: ''
	  buyer_email: ''
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
	    seller_email: ''
	    buyer_email: ''
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

	$scope.SendVerificationMsg = (sent)->
	  $http.get("/two_factors/sms?refresh="+sent)
	  return false

	alreadysent = false
	$scope.resentVerificationMsg = (_this)->
	  textmsg = $(_this).data("alt-name")
	  defmsg = $(_this).data("orig-name")
	  $(_this).attr("disabled",true)
	  countst = 30
	  rsc = setInterval (->
	    if(countst <= 0)
	      clearInterval(rsc)
	      $(_this).removeAttr("disabled")
	      .text(defmsg)
	      return false
	    $(_this).text(textmsg.replace("COUNT",countst))  
	    countst--
	  ), 1000
	  $scope.SendVerificationMsg(alreadysent) 
	  alreadysent = true
	  return false 


	$scope.loadTowFactor = (ecr_resp)->
	  $scope.is_page_loading = true 	
	  $http.get("/two_factors?respas=noheader")
	    .success (twofectresp)->
	      $scope.is_page_loading = false 
	      $(".twofectorauth").html(twofectresp)
	      $(".twofectorauth").find(".col-md-12.col-sm-13.col-xs-24").attr("class","col-md-23")
	      

	      verifybtn = $(".twofectorauth").find(".form-submit");
	      resend = $(".twofectorauth").find(".send-code-button");
	      drp_toggle = $(".twofectorauth").find(".dropdown-toggle")
	      hintapp = $(".twofectorauth").find(".hint.app");
	      hintsms = $(".twofectorauth").find(".hint.sms");
	      orgname = resend.find("button[type=submit]").data("orig-name");
	      
	       
	      drp_toggle.click ()->
	        $(".twofectorauth").find(".dropdown-menu").toggle()
	        
	      $(".twofectorauth").find(".dropdown-menu").find("a").click ()->
	      	dauth = $(this).data("type");
	      	dcontent = $(this).text();
	      	$(".twofectorauth").find(".input-group-btn").find("button").text(dcontent);
	      	$(".twofectorauth").find("input.two_factor_auth_type").val(dauth);
	      	$(".twofectorauth").find(".dropdown-menu").toggle()
	      	resend.find("button[type=submit]").text(orgname);
	      	if dauth == "sms"
	      	  resend.removeClass("hide")
	      	  hintsms.removeClass("hide")
	      	  $(hintapp).hide()
	      	else
	      	  resend.addClass("hide")
	      	  hintsms.addClass("hide")
	      	  hintapp.removeClass("hide")
	      	resend.find("button[type=submit]").click ->
	      	  $scope.resentVerificationMsg(this)
	      	  return false
	      verifybtn.find("input[type=submit]").click ((reEvent)->
	      	$scope.is_page_loading = true
	      	$scope.verifyTwofectoAuth(this,ecr_resp)
	      	return false
	      )	  

	  return false      	   

	      	
	      #$scope.twofactor_html = $sce.trustAsHtml(twofectresp)	
	      #alert(resend)
	      #verifybtn.show() 

	$scope.verifyTwofectoAuth = (_this, ecr_resp)->
	  $scope.is_page_loading = true 
	  $scope.two_fetor_error = ""	
	  authenticity_token = $(".twofectorauth").find("input[name=authenticity_token]").val()
	  two_factor_type = $(".twofectorauth").find("input[name='two_factor[type]']").val() 
	  two_factor_otp = $(".twofectorauth").find("input[name='two_factor[otp]']").val()

	  request_data = {
	  	eid: ecr_resp.escrow_id,
	  	acode: "escrow",
	  	utf8: "✓",
	  	_method: "patch",
	  	commit: "Verify",
	  	authenticity_token: authenticity_token,
	  	two_factor: {
	  		type: two_factor_type
	  		otp: two_factor_otp
	  	}
	  }	
		
	  $http.post("/two_factors/validatetrans",request_data)
	    .success (tf_resp)->
	      $scope.is_page_loading = false 
	      if tf_resp.success
	        $scope.page_index = 4
	      else  
	        $scope.two_fetor_error = tf_resp.errors
	  return false      


 


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
	    $scope.is_page_loading = false
	    $scope.current_user = current_user = resp.user
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
	    email_pattern = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/  
	    pattern = /^[0-9-+]+$/
	    plenth = $scope.transaction.phone.length
	    # validate phone  
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

	    if $scope.transaction.role == "buyer"
	      if $scope.transaction.seller_email == ""
	        $scope.errors.seller_email = "Please fill the seller's email address"
	      if email_pattern.test($scope.transaction.seller_email)
	      else
	        $scope.errors.seller_email = "Please fill the valid seller's email address"

	    if $scope.transaction.role == "seller"
	      if $scope.transaction.buyer_email == ""
	        $scope.errors.buyer_email = "Please fill the buyer's email address" 
	      if email_pattern.test($scope.transaction.buyer_email)
	      else
	        $scope.errors.buyer_email = "Please fill the valid buyer's email address" 

	    if $scope.transaction.role == "broker"
	      if $scope.transaction.seller_email == ""
	        $scope.errors.seller_email = "Please fill the seller's email address"
	      if $scope.transaction.buyer_email == ""
	        $scope.errors.buyer_email = "Please fill the buyer's email address"
	      if email_pattern.test($scope.transaction.seller_email)
	      else
	        $scope.errors.seller_email = "Please fill the valid seller's email address"
	      if email_pattern.test($scope.transaction.buyer_email)
	      else
	        $scope.errors.buyer_email = "Please fill the valid buyer's email address"     



	    angular.forEach $scope.errors, (value, key)->
	      if value == ""
	      else $scope.is_valid = false 

	    if $scope.is_valid 
	      $scope.is_page_loading = true 
	      $http.patch("/money/escrow.json", $scope.transaction)
	      .success (ecr_resp)->
	        $scope.is_page_loading = true 
	        if ecr_resp.success
	          $scope.processWithTwoFector(ecr_resp)
	        else
	          angular.forEach ecr_resp.errors, (value, key)->
	            if key == "tn_amount"
	              $scope.errors.amount = value[0]

	            if key == "email"
	              $scope.errors.email = value[0]  

	            if key == "tn_type"
	              $scope.errors.type = value[0]  

	            if key == "tn_role"
	              $scope.errors.role = value[0]  

	            if key == "phone"
	              $scope.errors.phone = value[0]  

	            if key == "tn_currency"
	              $scope.errors.currency = value[0] 

	            if key == "tn_amount"
	              $scope.errors.amount = value[0]  

	            if key == "item_name"
	              $scope.errors.item_name = value[0]  

	            if key == "shipping_currency"
	              $scope.errors.shipping_currency = value[0]  

	            if key == "fee_payer"
	              $scope.errors.fee_payer = value[0]  

	            if key == "inspection_length"
	              $scope.errors.inspection_length = value[0]  

	            if key == "descriptions"
	              $scope.errors.descriptions = value[0]  

	$scope.processWithTwoFector = (ecr_resp)->
	  $scope.page_index = 3
	  if ecr_resp.two_fetor.is_active
	    $scope.loadTowFactor(ecr_resp) 
	  else
	    $scope.two_fetor_error = "Please activate two fector autentication to move on next step"

	$scope.sms_and_app_activated = ->
      current_user.app_activated and current_user.sms_activated

  	$scope.only_app_activated = ->
      current_user.app_activated and !current_user.sms_activated

  	$scope.only_sms_activated = ->
      current_user.sms_activated and !current_user.app_activated

	  #$scope.auth = 


	            
	        

	    




	  
	      
	       
	            
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

 