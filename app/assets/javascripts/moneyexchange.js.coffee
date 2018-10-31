 

#= require pusher.min
#= require ./lib/tiny-pubsub 
#= require angular
#= require angular-resource
#= require_tree ./helpers
#= require_tree ./component_mixin
#= require_tree ./component_data
#= require_tree ./component_ui
#= require_tree ./funds/filters

 
window.app = app = angular.module 'money', ['translateFilters','textFilters']

#= require_tree ./funds/models

#= require_tree ./funds/services
#= require_tree ./funds/directives
#= require ./funds/events
 

 

app.factory '$gon', ['$window', (win)-> win.gon]

 

app.controller 'exChangeController', ['$scope','$http', '$gon',($scope, $http, $gon) ->
  $scope.current_user = current_user = $gon.current_user

  $.subscribe 'two_factor_init', (event, data) ->
    TwoFactorAuth.attachTo('.two-factor-auth-container')
  $.publish 'two_factor_init'


  $scope.sms_and_app_activated = ->
    #alert current_user.app_activated
    current_user.app_activated and current_user.sms_activated

  $scope.only_app_activated = ->
    current_user.app_activated and !current_user.sms_activated

  $scope.only_sms_activated = ->
    current_user.sms_activated and !current_user.app_activated



]


 

    	
