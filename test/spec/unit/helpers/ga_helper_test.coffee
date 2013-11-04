###

  GaHelper test

###

module 'GaHelper',
  setup: ->
    Em.run ->
      Openedui.reset()
      Openedui.deferReadiness()

test 'adds tracker image to document', ->
  conversion = Openedui.GaHelper.conversions.search
  expected = '//www.googleadservices.com/pagead/conversion/' +
    "#{conversion.id}/?label=#{conversion.label}&value=1&guid=ON&script=0"
  equal Openedui.GaHelper.trackConversion('search'), expected, 'Expected ' + expected

