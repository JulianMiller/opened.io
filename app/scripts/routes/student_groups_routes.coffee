Openedui.StudentGroupsRoute = Openedui.AuthenticatedRoute.extend
  model: ->
    Openedui.StudentGroup.find()

Openedui.StudentGroupsJoinRoute = Openedui.AuthenticatedRoute.extend
  setupController: (controller) ->
    controller.reset()

Openedui.StudentGroupRoute = Openedui.AuthenticatedRoute.extend
  model: (params)->
    Openedui.StudentGroup.find(params.group_id)

  renderTemplate: ->
    @render "student_groups/student_group"

