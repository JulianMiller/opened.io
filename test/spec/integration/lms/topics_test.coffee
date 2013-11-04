###

  Topics test for LMS

###

data = Openedui.Topic.FIXTURES

topicListCssClass = '.ts-topic-list .list__blocks__item'

topicElements =
  addNewButton:     '.ts-topic-addNewButton'
  deleteButton:     '.ts-topic-deleteButton'
  form:             '.ts-topic-form'
  title:            '.ts-topic-title'
  description:      '.ts-topic-description'
  sumbitNewButton:  '.ts-topic-sumbitNewButton'
  listTitle:        '.ts-topic-list-title'

newTopicText =
  title: 'New Topic'
  description: 'New Topic Description'

savedMsg = null

getTopicOrder = (course)->
  order = []
  course.get('topics').map (topic) ->
    order.push(topic.get('id'))

  return order

module 'Topics', ->
  setup: ->
    Openedui.reset()

test 'has correct routing for single topic', ->
  topicId = 1
  visit('/courses/1/topics/' + topicId ).then ->
    topicTitle =  Openedui.Topic.find(topicId).get('title')
    equal(find(topicElements.title).val(), topicTitle, 'the value in input equal to topic visiting topic title')

test 'list has right number of items for a course which has topics', ->
  visit('/courses/1/topics').then ->
    itemsQty = find(topicListCssClass).length
    equal(itemsQty, Openedui.Course.find(1).get('topics.length'), 'qty of topics in the list equals to topics at course with id=1')

test 'list is empty if course does not have topics', ->
  visit('/courses/3/topics').then ->
    itemsQty = find(topicListCssClass).length
    equal(itemsQty, 0, 'there is no topics in course with 0 topics')

test 'we can add a topic', ->
  expect(4)
  oldItemsQty = null

  visit('/courses/1/topics').then ->
    addNewButton = find(topicElements.addNewButton)
    oldItemsQty = find(topicListCssClass).length

    ok(addNewButton.length, 'Add new topic button exists')

    click(addNewButton)
  .then ->

    ok(find(topicElements.form).length, 'the form for new topic exists')

    # filling the new topic form with data
    fillIn(topicElements.title, newTopicText.title)
    fillIn(topicElements.description, newTopicText.description)

    click(topicElements.sumbitNewButton)
  .then ->

    # after creating new topic we go to its page
    newTopic = Openedui.__container__.lookup('controller:topic')

    equal(find(topicElements.title).val(), newTopic.get('title'), 'created topic had the same title as what we see in the input')

    newTopcisQty = Openedui.__container__.lookup('controller:course').get('topics.length')

    equal(oldItemsQty + 1, newTopcisQty, 'the quantity of topics in the course + 1 than it used to be')

test 'we can reorder topics', ->
  expect(3)

  courseId = 1
  course = Openedui.Course.find(courseId)
  currOrder = getTopicOrder(course)

  ###

    we going to move the first topic to very bottom
    using controller method TopicsController.updateContent()
    but after we going to check if something has changed at the UI side

  ###
  firstTopicId = course.get('topics').objectAt(0).get('id')
  itemsQty = course.get('topics.length')


  visit('/courses/' + courseId + '/topics').then ->
    controller = Openedui.__container__.lookup('controller:topics')

    #moving first topic to the bottom e.g. from 0 position to the last (itemsQty)
    Em.run => controller.updateContent(0, itemsQty)

    newOrder = getTopicOrder(course)

    notDeepEqual(currOrder, newOrder, 'the new order is not equal the old one')

    # find the id of the last one topic in current situation
    lastTopicId = course.get('topics').objectAt(itemsQty - 1).get('id')

    equal(firstTopicId, lastTopicId, 'the first topic has been moved to very bottom')

    # finally assert that title of bottom item is equal to title of the last topic in course data
    lastTopicTitle = $(topicListCssClass).last().find(topicElements.listTitle).text()

    equal(lastTopicTitle, Openedui.Topic.find(lastTopicId).get('title'), 'title of last topic at UI is equal to last topic in course data')

test 'we can delete a topic', ->
  expect(3)
  oldItemsQty = null

  visit('/courses/1/topics/1').then ->
    deleteButton = find(topicElements.deleteButton)
    oldItemsQty = Openedui.Topic.FIXTURES.length

    ok(deleteButton.length, 'delete button exists')

    window.confirm = (msg) ->
      savedMsg = msg

    click(deleteButton)
  .then ->
    itemsQty = $(topicListCssClass).length;
    equal(itemsQty, oldItemsQty - 1, 'the new qty of topics is - 1 than previous')
    notEqual(savedMsg, "", 'Expected confirm message not empty')
