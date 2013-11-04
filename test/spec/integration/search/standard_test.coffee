###

  Standard test

###

module 'Standard',
  setup: ->
    Em.run ->
      Openedui.reset()
      Openedui.deferReadiness()

test 'loads standards', ->
  expect(1)
  Ember.run Openedui, 'advanceReadiness'
  visit('/search/standard_groups/2/categories/150/standards').then ->
    rows = find('.nav.nav-list > li').length
    equal(rows, 3, 'Expected 3 standards but loaded ' + rows)