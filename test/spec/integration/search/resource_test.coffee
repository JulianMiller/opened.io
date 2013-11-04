###

  Resource test

###

module 'Resource',
  setup: ->
    Em.run ->
      Openedui.reset()
      Openedui.deferReadiness()

test 'loads resources from directory tab', ->
  expect(1)
  Ember.run Openedui, 'advanceReadiness'
  visit('/search/areas/1/subjects/6/resources').then ->
    rows = find('.resource__list > li').length
    equal(rows, 2, 'Expected 2 resources but loaded ' + rows)

test 'loads resources from standards tab', ->
  expect(1)
  Em.run Openedui, 'advanceReadiness'
  visit('/search/standard_groups/2/categories/150/standards/7020/resources').then ->
    rows = find('.resource__list > li').length
    equal(rows, 2, 'Expected 2 resources but loaded ' + rows)

test 'loads resource window', ->
  expect(5)
  Em.run Openedui, 'advanceReadiness'
  visit('/search/standard_groups/2/categories/150/standards/7020/resources').then ->
    click($("[href='/search/resources/66946']"))
  .then ->
    equal($(".popup").length, 1, 'Expected Popup window found')
    equal($(".ts-resource-modal-close").length, 1, 'Expected Close button found')
    equal($(".ts-resource-content-input").length, 1, 'Expected Input with href found')
    equal($(".ts-resource-content").length, 1, 'Expected Content found')
    equal($(".resource__subtitle").eq(0).text().trim(), Openedui.Resource.FIXTURES[0].contribution_name, 'Expected Subtitle found')

test 'loads share route for a resource', ->
  expect(2)
  Em.run Openedui, 'advanceReadiness'
  visit('/share/66946').then ->
    ok(find('.title-style-h3:contains("English Vocabulary Lessons-Bedroom Objects")').length, 'The resource title should display')
    ok(find('input[value="' + window.location.protocol + '//' + window.location.host + '/#/share/66946"]').length, 'The resource permalink should display')
