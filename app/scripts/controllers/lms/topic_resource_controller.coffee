###

  This controller supports individual resource for topic page

  ItemController for Openedui.AssignedController, Openedui.TopicPlaylistResourcesController,
  Openedui.RecommendedController

###

Openedui.TopicResourceController = Ember.ObjectController.extend
  needs: ['topic']
  topicResource: true
  isLoading: false

  isAssigned: ( ->
    currentId = @get('id')
    @get('controllers.topic.assignedResourcesIds').contains currentId
  ).property('controllers.topic.assignedResourcesIds')

  isSelected: ( ->
    unless @get("target") instanceof Openedui.AssignedController then @get('isAssigned')
  ).property('controllers.topic.assignedResourcesIds')


  actions:
    ###

      Assigning resources to topic
      @param {Number}

    ###
    assignResource: (resource_id) ->
      resource = Openedui.Resource.find(resource_id)
      topic = @get('controllers.topic.content')
      topic.get('resources').pushObject(resource)

    ###

      Removing assigned resources to topic
      @param {Number}

    ###
    removeResource: (resource_id) ->
      resource = Openedui.Resource.find(resource_id)
      topic = @get('controllers.topic.content')
      topic.get('resources').removeObject(resource)
