###

  This controller supports recommended resources list
  on the topic page of LMS

###
Openedui.RecommendedController = Ember.ArrayController.extend
  needs: ['topic', 'course']
  # explicitly assigning controller for children, overwriting ResourceController for items
  itemController: 'topicResource'
  isLoading: false

  ###

    building a query for recommend api

    @method buildQuery
    @param topic {Openedui.Topic}
    @param course {Openedui.Course}

  ###
  buildQuery: (topic, course) ->
    #creating query to pass as parameters to recommended api
    return query =
      v: Openedui.API.version
      limit: Openedui.API.resources_limit
      grade: course.get('grade')
      course_title: course.get('title')
      title: topic.get('title')
      description: topic.get('description')
      standard_identifier: topic.get('standard_idents')[0]

  ###

    Updating content of recommended resources
    based on information from topics and course, aka 'query'

    @method updateContent
    @param query {Object}

  ###
  updateContent: (query) ->
    unless @get('isLoading')
      @set('isLoading', true)
      model = Openedui.Recommend.find(query)
      @set('content', model)
      model.one 'didLoad', =>
        @set('isLoading', false)

