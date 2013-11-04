
###

  Classes
  Same behavior as topics here, with sigle class displaying in the parent outlet
  courses/:course_id/classes - displays list of the classes inside course
  coucrses/:course_di/classes/:class_id - displays class in the course template in the main outlet

###

Openedui.ClassesRoute = Openedui.AuthenticatedRoute.extend()


Openedui.ClassesIndexRoute = Openedui.AuthenticatedRoute.extend
  renderTemplate: ->
    @render "courses/course",
      into: "courses"
      controller: @controllerFor('course')

    @render  "classes/list",
      into: "courses/course"

  model: ->
    course_id = @modelFor("course").get("id")
    Openedui.Group.find(course_id: course_id)

Openedui.ClassRoute = Openedui.AuthenticatedRoute.extend
  renderTemplate: ->
    @render 'classes/class',
      into: "courses"
  model: (params) ->
    Openedui.Group.find params.class_id


Openedui.ClassesNewRoute = Openedui.AuthenticatedRoute.extend
  setupController: (controller) ->
    controller.setProperties
      name: null
      errorMessage: null
      isLoading: false
      isNew: true



