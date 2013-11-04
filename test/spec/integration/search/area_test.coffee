###

  Area test

###

module 'Area',
  setup: ->
    Em.run ->
      Openedui.reset()
      Openedui.deferReadiness()

test 'loads areas', ->
  expect(1)
  Ember.run Openedui, 'advanceReadiness'
  visit('/search/areas').then ->
    rows = find('.nav.nav-list > li').length
    equal(rows, 3, 'Expected 3 areas but loaded ' + rows)
