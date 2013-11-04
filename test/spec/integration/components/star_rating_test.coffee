###

  Resource test

###

module 'StarRatingComponent',
  setup: ->
    Em.run ->
      Openedui.reset()
      Openedui.deferReadiness()

test 'creates stars with default value (0)', ->
  expect(1)
  Ember.run Openedui, 'advanceReadiness'
  stars = Openedui.StarRatingComponent.create()
  array = stars.get('stars').toArray()
  expected = [
    {isOn: false}
    {isOn: false}
    {isOn: false}
    {isOn: false}
    {isOn: false}
  ]
  equal(
    JSON.stringify(array), 
    JSON.stringify(expected), 
    'Expected default stars but loaded ' + JSON.stringify(array)
  )

test 'creates stars with value (3)', ->
  expect(1)
  Ember.run Openedui, 'advanceReadiness'
  stars = Openedui.StarRatingComponent.create(value: 3)
  array = stars.get('stars').toArray()
  expected = [
    {isOn: true}
    {isOn: true}
    {isOn: true}
    {isOn: false}
    {isOn: false}
  ]
  equal(
    JSON.stringify(array), 
    JSON.stringify(expected), 
    'Expected stars with value 3 but loaded ' + JSON.stringify(array)
  )  

test 'loads resource with rating (2)', ->
  expect(1)
  Ember.run Openedui, 'advanceReadiness'
  visit('/search/areas/1/subjects/6/resources').then ->
    rows = find('ul.rating:eq(0) > li > i.icon-star').length
    equal(rows, 2, 'Expected 2 stars but loaded ' + rows)

# test 'loads resource with my rating (4)', ->
#   expect(1)
#   Ember.run Openedui, 'advanceReadiness'
#   authenticate()
#   visit('/search/areas/1/subjects/6/resources').then ->
#     rows = find('ul.rating:eq(1) > li > i.icon-star').length
#     equal(rows, 4, 'Expected 4 stars but loaded ' + rows)
