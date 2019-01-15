@TwoFactorAuth = flight.component ->
  console.log("cap_intialize_loaded")
  @attributes
    switchName: 'span.switch-name'
    switchItem: '.dropdown-menu a'
    switchItemApp: '.dropdown-menu a[data-type="app"]'
    switchItemSms: '.dropdown-menu a[data-type="sms"]'
    sendCodeButtonContainer: '.send-code-button'
    sendCodeButton: 'button[value=send_code]'
    authType: '.two_factor_auth_type'
    appHint: 'span.hint.app'
    smsHint: 'span.hint.sms'
    chapterWrap: '.captcha-wrap'

    console.log("cap_intialize_loaded_1")

  @setActiveItem = (event) ->
    switch $(event.target).data('type')
      when 'app' then @switchToApp()
      when 'sms' then @switchToSms()

  @switchToApp = ->
    @select('switchName').text @select('switchItemApp').text()
    @select('sendCodeButtonContainer').addClass('hide')
    @select('authType').val('app')
    @select('smsHint').addClass('hide')
    @select('appHint').removeClass('hide')

  @switchToSms = ->
    @select('switchName').text @select('switchItemSms').text()
    @select('sendCodeButtonContainer').removeClass('hide')
    @select('authType').val('sms')
    @select('smsHint').removeClass('hide')
    @select('appHint').addClass('hide')

  @countDownSendCodeButton = ->
    origName  = @select('sendCodeButton').data('orig-name')
    altName   = @select('sendCodeButton').data('alt-name')
    countDown = 30

    @select('sendCodeButton').attr('disabled', 'disabled').addClass('disabled')
    countDownTimer = =>
      setTimeout =>
        if countDown isnt 0
          countDown--
          @select('sendCodeButton').text(altName.replace('COUNT', countDown))
          countDownTimer()
        else
          @select('sendCodeButton').removeAttr('disabled').removeClass('disabled').text(origName)
      , 1000
    countDownTimer()

  @sendCode = (event) ->
    event.preventDefault()

    @countDownSendCodeButton()
    $.get('/two_factors/sms?refresh=true')

  @checkCaptchaRequired = ->
    console.log("cap_intialized_1")
    @select('chapterWrap').load '/two_factors/app', (html) -> 
      console.log("cap_intialized_2")
      console.log(html)
      $(@).html(html)

  @after 'initialize', ->
    @checkCaptchaRequired()
    $.subscribe 'withdraw:form:submitted', => @checkCaptchaRequired()
    @on @select('switchItem'), 'click', @setActiveItem
    @on @select('sendCodeButton'), 'click', @sendCode
    console.log("cap_intialized")

