###

  This controller supports topic on LMS

###
Openedui.TopicController = Ember.ObjectController.extend
  needs: ['course', 'recommended', 'topic_search_resources']
  isLoading: false

  assignedResourcesIds:( ->
    ids = Em.A()
    @get('resources').map (resource) ->
      ids.push(resource.get('id'))

    return ids
  ).property('resources.@each')

  # reverse isDirty property to corretly apply disabled attributes to buttons
  isNotDirty: (->
    !@get('isDirty')
  ).property('isDirty').cacheable()

  selectStandardMethod: (standard) ->
    #TODO support multiple standards
    @set('standard_idents', [standard.get('identifier')])

  # Topic actions for top buttons
  actions:
    deleteRecord: (topic) ->
      #TODO wrap window.confirm in cool UI plugin
      confirm = window.confirm('You are about to delete the topic, there is no undo. Do you want to proceed?')
      if (confirm)
        course = @get('course')
        topic.deleteRecord()
        topic.get('transaction').commit()
        topic.one 'didDelete', =>
          Em.run.next =>
            @transitionToRoute('topics', course)
            #refresh hasMany relationships in the course
            #https://github.com/emberjs/data/pull/641
            course.reload()

    discardChanges: (topic) ->
      # discard changes on model if we only modify it
      if(topic.get('isDirty'))
        topic.rollback()

    saveChanges: (topic) ->
      unless @get('isLoading')
        @set('isLoading', true)
        topic.get('transaction').commit()
        topic.one 'didUpdate', =>

          # call recommended api to update results
          # after we updated topic fields
          course = @get('controllers.course')
          recommendedController = @get('controllers.recommended')
          query = recommendedController.buildQuery(this, course)
          recommendedController.updateContent(query)

          #update search results
          @get('controllers.topic_search_resources').updateContent()
          @set('isLoading', false)

    # action from select standard drop-down
    selectStandard: (standard) ->
      @selectStandardMethod(standard)