###

  Standard Group model test

###

module 'StandardGroup Model',
  setup: ->
    Em.run ->
      Openedui.reset()
      Openedui.deferReadiness()

test 'displays group resource count', ->
  expect(1)
  Em.run ->
    Openedui.advanceReadiness()
    count = 1500
    group = Openedui.StandardGroup.createRecord name: 'Some Group', count: count
    localeCount = count.toLocaleString("en-US")

    equal group.get('format_count'), localeCount, "Expected #{localeCount} but got " + group.get('format_count')
