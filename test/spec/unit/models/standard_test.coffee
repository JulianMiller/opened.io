###

  Standard model test

###

module 'Standard Model',
  setup: ->
    Em.run ->
      Openedui.reset()
      Openedui.deferReadiness()

test 'displays standard resource count', ->
  expect(1)
  Em.run ->
    Openedui.advanceReadiness()
    count = 1200

    standard = Openedui.Standard.createRecord
      title: 'Some Standard'
      identifier: '5.RL.7'
      count: count

    localeCount = count.toLocaleString("en-US")

    equal standard.get('format_count'), localeCount, "Expected #{localeCount} but got " + standard.get('format_count')

test 'displays standard label', ->
  expect(1)
  Em.run ->
    Openedui.advanceReadiness()
    standard = Openedui.Standard.createRecord
      title: 'Some Standard'
      identifier: '5.RL.7'
    equal standard.get('label'),
      '5.RL.7: Some Standard',
      'Expected "5.RL.7: Some Standard" but got ' + standard.get('label')
