###

  Topics
  courses/:course_id/topics - displays list of the topics inside course
  courses/:course_id/topics/:topic_id - displays topic in the course template in the main outlet
  courses/:course_id/topics/new - create new topic

###
Openedui.TopicsRoute = Openedui.AuthenticatedRoute.extend
  setupController: (controller, model)->
    # model hook in case of hasMany relationship and creating a new parent record
    # returns an empty array and crashed the route
    controller.set('content', @modelFor('course').get('topics'))


# on topics index page (/courses/3/topics) we need to recreate a whole layout, because we can get here with back button
Openedui.TopicsIndexRoute = Openedui.AuthenticatedRoute.extend
  renderTemplate: ->
    @render "courses/course",
      into: "courses"
      controller: @controllerFor('course')

    @render  "topics/list",
      into: "courses/course"
      controller: @controllerFor('topics')

Openedui.TopicIndexRoute = Openedui.AuthenticatedRoute.extend
  redirect: ->
    # figure out if topics has assigned resources
    # if not redirect to recommended resources
    resourcesLen = @modelFor('topic').get('resources.length')
    if resourcesLen == 0
      @transitionTo('recommended')
    else
      @transitionTo('assigned')

  beforeModel: ->
    # set keyword to null for search by standards
    @controllerFor('topic_search_resources').set('descriptive', null)

Openedui.TopicRoute = Openedui.AuthenticatedRoute.extend
  renderTemplate: ->
    @render "topics/topic",
      into: "courses"

  actions:
    willTransition: (transition) ->
      topic = @currentModel
      # autocommit changes without prompt user about saving
      if topic.get('isDirty')
        topic.get('transaction').commit()
        topic.one 'didUpdate', ->
          transition.retry()
        transition.abort()
      else
        return true

Openedui.TopicsNewRoute = Openedui.AuthenticatedRoute.extend
  model: ->
    course = @modelFor('course')
    Openedui.Topic.createRecord
      standard_idents: []
      course: course

###

  Assigned Resources for topic
  courses/:course_id/topics/:topic_id/assigned

###
Openedui.AssignedRoute = Openedui.AuthenticatedRoute.extend
  renderTemplate: ->
    @render "topics/assigned"

  setupController: (controller, model)->
    # TODO: model hook in this case behaves really wierd
    # at the new topic it returned empty array and crashed route :(
    # check TopicsRoute for same behavior
    controller.set('content', @modelFor('topic').get('resources'))

###

  Recommended Resources for topic
  courses/:course_id/topics/:topic_id/recommended

###
Openedui.RecommendedRoute = Openedui.AuthenticatedRoute.extend
  model: ->
    topic = @modelFor('topic')
    course = @modelFor('course')
    query = @controllerFor('recommended').buildQuery(topic, course)
    Openedui.Recommend.find(query)

  renderTemplate: ->
    @render "topics/recommended"


###

  Resources for Playlist for topic
  courses/:course_id/topics/:topic_id/from_playlist

###
Openedui.TopicPlaylistResourcesRoute = Openedui.AuthenticatedRoute.extend
  setupController: (controller) ->
    controller.set 'playlists', Openedui.Playlist.find()

  renderTemplate: ->
    @render "topics/playlist_resources"

###

  Search Resources for topic
  courses/:course_id/topics/:topic_id/search

###
Openedui.TopicSearchResourcesRoute = Openedui.AuthenticatedRoute.extend
  model: ->
    topic = @modelFor('topic')
    search = @controllerFor('topicSearchResources')
    # if search form idents are empty, pick from the topic
    standard_idents = if search.get('standard_idents') then search.get('standard_idents') else topic.get('standard_idents')

    # create query for search
    query = search.buildQuery(standard_idents, search.get('descriptive'))
    Openedui.Resource.find(query)

  renderTemplate: ->
    @render "topics/search_resources"


