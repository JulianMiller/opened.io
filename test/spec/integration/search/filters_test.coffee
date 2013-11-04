###

  Filters test

###

module 'Resource Filters',
  setup: ->
    Em.run ->
      Openedui.reset()
      Openedui.deferReadiness()

test 'loads resource types in dropdown (including all)', ->
  expect(1)
  Ember.run Openedui, 'advanceReadiness'
  visit('/search/areas').then ->
    rows = find('#types-filter option').length
    equal(rows, 4, 'Expected 4 type options but loaded ' + rows)

test 'loads contributions in dropdown (including all)', ->
  expect(1)
  Ember.run Openedui, 'advanceReadiness'
  visit('/search/areas').then ->
    rows = find('#contributions-filter option').length
    equal(rows, 3, 'Expected 3 source options but loaded ' + rows)

test 'loads grades as button-toolbar (including all)', ->
  expect(1)
  Ember.run Openedui, 'advanceReadiness'
  visit('/search/areas').then ->
    rows = find('#grades button').length
    equal(rows, 14, 'Expected 14 grade options but loaded ' + rows)

test 'selects grade radio button', ->
  expect(1)
  Ember.run Openedui, 'advanceReadiness'
  visit('/search/areas').then ->
    click('#grades button:first')
  .then ->
    rows = find('#grades button.active [data-value="K"]').length
    equal(rows, 1, 'Expected K grade to be selected but loaded ' + rows)

test 'resets filters when route changes', ->
  expect(3)
  Ember.run Openedui, 'advanceReadiness'
  visit('/search/standard_groups/2/categories/150/standards/7020/resources').then ->
    click('#grades button:first')
    select('option[value="YouTube"]')
    select('option[value="video"]')
  .then ->
    visit('/search/standard_groups/2/categories/150/standards/7022/resources')
  .then ->
    rows = find('#grades button.active').length
    equal(rows, 0, 'Expected 0 grades to be selected but loaded ' + rows)
    text = find('#contributions-filter :selected').text()
    equal(text, 'All Sources', 'Expected all sources to be selected but loaded ' + text)
    text = find('#types-filter :selected').text()
    equal(text, 'All Resources', 'Expected all resources to be selected but loaded ' + text)