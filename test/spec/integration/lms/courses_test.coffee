###

  Courses test for LMS

###

courseCssClass = '.ts-course-list-item'
resourceCssClass = '.ts-resource-item'

courseElements =
  button: '.ts-newCourse-button'
  form: '.ts-course-form'
  title: '.ts-newCourse-title'
  grade: '.ts-newCourse-grade'
  description: '.ts-newCourse-description'
  createButton: '.ts-newCourse-createButton'
  deleteButton: '.ts-course-deleteButton'
  studentVeiwTopic: '.ts-student-view-topic'

newCourseText =
  title: 'New Course'
  grade: '2'
  description: 'New Course Description'
  topcis: []

module 'Courses',
  setup: ->
    Openedui.reset()

test 'General routing check', ->
  expect(2)

  ok(Openedui.Course, 'the course model exists')

  visit('/courses').then ->
    ok(exists('h1:contains("Courses")'))

test 'Loading proper qty', ->
  expect(2)

  visit('/courses').then ->
    itemsQty = $(courseCssClass).length;
    notEqual(itemsQty, 0, 'Thre are some courses on the page')
    equal(itemsQty, Openedui.Course.FIXTURES.length, 'qty of courses DOM items = length of data')

test 'Displaying proper blank-state', ->
  visit('/courses').then ->
    ok(exists('.msg--empty'))

test 'Can create a new course', ->
  expect(2)
  oldItemsQty = Openedui.Course.FIXTURES.length

  visit('/courses').then ->
    click(courseElements.button).then ->
      ok(exists(courseElements.form), 'the new course form has been opened')

      fillIn(courseElements.title, newCourseText.title)
      fillIn(courseElements.description, newCourseText.description)
      select("option[value='#{newCourseText.grade}']")

      click(courseElements.createButton).then ->
        itemsQty = $(courseCssClass).length
        equal(itemsQty, oldItemsQty + 1, 'We have one more course in the left list of courses')

test 'Can delete a course', ->
  expect(2)
  oldItemsQty = Openedui.Course.FIXTURES.length
  savedMsg = null

  visit('/courses/2').then ->
    window.confirm = (msg) ->
      savedMsg = msg

    click(courseElements.deleteButton).then ->
      itemsQty = $(courseCssClass).length;
      equal(itemsQty, oldItemsQty - 1, 'the new qty of courses is - 1 than previous')
      notEqual(savedMsg, "", 'Expected confirm message not empty')

test 'The length of fixtures and getting from Resource model are the same', ->
  resources = Openedui.Topic.find(1).get('resources')
  resourcesFIXTURES = Openedui.Resource.FIXTURES

  visit('/courses/1/student_view').then ->
    equal(resourcesFIXTURES.get('length'), resources.get('length'))


test 'Can open the student view and see the right number of topics and resources', ->
  expect(2)
  courseId = 1
  topics = Openedui.Course.find(courseId).get('topics')

  visit('/courses/1/student_view').then ->
    topicsElements = find(courseElements.studentVeiwTopic)
    resources = Openedui.Topic.find(1).get('resources')

    equal(topics.get('length'), topicsElements.length, 'The qty of topics at the student view equal to topics in the course')
    equal(resources.get('length'), find(resourceCssClass).length, 'The qty of resources is correct' )






