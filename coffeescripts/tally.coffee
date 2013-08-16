class TallyMarks
  constructor: ->
    @bind_events()

  bind_events: ->
    $('.tally').on 'DOMSubtreeModified', @changeEvent
    $('.tally').trigger 'DOMSubtreeModified'

  changeEvent: (e) =>
    @doTally $(e.currentTarget)

  doTally: ($el) ->
    val = parseInt( $el.text() )
    val = 0 if isNaN val
    fives = parseInt( val / 5 )
    change = Math.abs( val % 5 )

    next = $el.next()
    $(next).remove() if $(next).hasClass('tally-mark')

    new_val = "#{( 5 for i in [0...fives] ).join('')}#{ if change == 0 then '' else change }"
    
    $hashEl = $el.after( $('<span>').addClass( $el.attr("class") ).addClass("tally-mark").text(new_val) )
    $hashEl.css($el.attr("style") or '')
   

window.TallyMarks = TallyMarks

jQuery ->
  window.tally_marks = new TallyMarks()