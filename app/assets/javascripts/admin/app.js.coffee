$ ->
  $('input[name*=created_at]').datetimepicker()

  $('[data-clipboard-text], [data-clipboard-target]').each ->
    zero = new Clipboard(this)

    $(this).on "mouseover", ()->
      text = $(this).data("clipboard-text")
      $(this).after("<span class='cpierr'>Click on text to Copy!</span>")

    $(this).on "mouseout", ()-> 
      $(this).next("span").remove()

    $(this).on "click", ()->  
      $(this).next("span").remove()
      $(this).after("<span class='cpierr'>Copied!</span>")
      setTimeout (->
        $(this).next("span").remove()
        return
      ),500
         




    zero.on 'success', (e)->
      #setTooltip(e.trigger, 'Copied!')
      #hideTooltip(e.trigger)
         

  #$('[data-clipboard-text], [data-clipboard-target]').each ->
    #zero = new ZeroClipboard($(@))

    #zero.on 'complete', ->
      #$(zero.htmlBridge)
        #.attr('title', 'done')
        #.tooltip('fixTitle')
        #.tooltip('show')
    #zero.on 'mouseout', ->
      #$(zero.htmlBridge)
        #.attr('title', 'copy')
        #.tooltip('fixTitle')

    #placement = $(@).data('placement') || 'bottom'
    #$(zero.htmlBridge).tooltip({title: 'copy', placement: placement})


    
