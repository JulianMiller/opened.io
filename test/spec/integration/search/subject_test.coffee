###

  Subject test

###

module 'Subject',
  setup: ->
    Em.run ->
      Openedui.reset()
      Openedui.deferReadiness()

test 'loads subjects', ->
  expect(1)
  Ember.run Openedui, 'advanceReadiness'
  visit('/search/areas/1/subjects').then ->
    rows = find('.nav.nav-list > li').length
    equal(rows, 3, 'Expected 3 subjects but loaded ' + rows)
