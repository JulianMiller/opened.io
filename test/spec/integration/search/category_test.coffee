###

  Category test

###

module 'Category',
  setup: ->
    Em.run ->
      Openedui.reset()
      Openedui.deferReadiness()

test 'loads categories', ->
  expect(1)
  Ember.run Openedui, 'advanceReadiness'
  visit('/search/standard_groups/2/categories').then ->
    rows = find('.nav.nav-list > li').length
    equal(rows, 3, 'Expected 3 categories but loaded ' + rows)