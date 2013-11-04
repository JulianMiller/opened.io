###

  Standard Group test

###

module 'StandardGroup',
  setup: ->
    Em.run ->
      Openedui.reset()
      Openedui.deferReadiness()

test 'loads standard_groups', ->
  expect(1)
  Em.run Openedui, 'advanceReadiness'
  visit('/search/standard_groups').then ->
    rows = find('.nav.nav-list > li').length
    equal(rows, 3, 'Expected 3 groups but loaded ' + rows)