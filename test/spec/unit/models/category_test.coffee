###

  Category model test

###

module 'Category Model',
  setup: ->
    Em.run ->
      Openedui.reset()
      Openedui.deferReadiness()

test 'displays category resource count', ->
  expect(1)
  Em.run ->
    Openedui.advanceReadiness()
    count = 1200
    category = Openedui.Category.createRecord title: 'Some Category', count: count
    localeCount = count.toLocaleString("en-US")

    equal category.get('format_count'), localeCount, "Expected #{localeCount} but got " + category.get('format_count')
