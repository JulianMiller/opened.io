###

  Courses
  courses - main page with list of courses and default message
  courses/:course_id - display the course information in the panel on the right
  courses/new - create new course

###
Openedui.CoursesRoute = Openedui.AuthenticatedRoute.extend
  model: ->
    Openedui.Course.find()

Openedui.CoursesNewRoute = Openedui.AuthenticatedRoute.extend
  setupController: (controller, model) ->
    controller.setProperties
      'isLoading': false
      'content': model

  model: ->
    Openedui.Course.createRecord()

  actions:
    willTransition: (transition) ->
      course = @currentModel
      if course.get('isNew')
        course.deleteRecord()


# course index page with default message for courses
Openedui.CoursesIndexRoute = Openedui.AuthenticatedRoute.extend
  renderTemplate: ->
    @render 'courses/index'

Openedui.CourseRoute = Openedui.AuthenticatedRoute.extend
  model: (params) ->
    Openedui.Course.find(params.course_id)

  actions:
    willTransition: (transition) ->
      course = @currentModel
      # autocommit changes without prompt user about saving
      if course.get('isDirty')
        course.get('transaction').commit()
        course.one 'didUpdate', ->
          transition.retry()
        transition.abort()
      else
        return true

# Recreating index page, caz we can get here with back button from topics/:topic_id, and its not clear for Ember
# how to reder it afterwards, becase topics/:topic_id transition messes layout
Openedui.CourseIndexRoute = Openedui.AuthenticatedRoute.extend
  renderTemplate: ->
    @render "courses/course",
      into: "courses"
      controller: @controllerFor('course')

###

  Student view route in the course
  courses/:course_id/student_view

###
Openedui.StudentViewRoute = Openedui.AuthenticatedRoute.extend
  renderTemplate: ->
    @render "courses/student_view",
      into: "courses"
      controller: @controllerFor('course')

