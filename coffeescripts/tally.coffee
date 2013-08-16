class TallyMarks
  constructor: ->
    @bind_events()

  bind_events: ->
    $('.tally:not(.tally-marks)').on 'DOMSubtreeModified', @changeEvent
    $('.tally:not(.tally-marks)').trigger 'DOMSubtreeModified'

  changeEvent: (e) =>
    @doTally $(e.currentTarget)

  doTally: ($el) ->
    val = parseInt( $el.text() )
    val = 0 if isNaN val
    fives = parseInt( val / 5 )
    change = Math.abs( val % 5 )

    next = $el.next()
    $(next).remove() if $(next).hasClass('tally-marks')

    new_val = "#{( 5 for i in [0...fives] ).join('')}#{ if change == 0 then '' else change }"
   
    cssObject = new StyleConv($el.attr("style")).asObject()
    classString = $el.attr("class")
    $el.after( $('<span>').css(cssObject).addClass(classString).addClass("tally-marks").text(new_val) )

   
    
class StyleConv
  constructor: (style) ->
    @style = style || ''

  asArray: ->
    @styleArray ?= @style.replace(/;\s*$/,'').split(/[:; ]+/)

  asObject: ->
    i = 0
    o = {}
    while @asArray().length > i+1
      o[ @asArray()[i] ] = @asArray()[i+1]
      i+=2
    o

window.TallyMarks = TallyMarks

jQuery ->
  window.tally_marks = new TallyMarks()