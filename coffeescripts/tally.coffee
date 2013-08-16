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
    change = val % 5

    for sibling in $el.siblings()
      unless $(sibling).hasClass('tally-mark') 
        break
      $(sibling).remove()

    $el.after $('<span>').addClass("tally-mark").text change unless change == 0
    $el.after $('<span>').addClass("tally-mark").text(5) for i in [0...fives]
   

window.TallyMarks = TallyMarks

jQuery ->
  window.tally_marks = new TallyMarks()