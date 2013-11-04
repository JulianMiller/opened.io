###

  This controller supports search by standard in topic page in LMS

###
Openedui.TopicSearchResourcesController = Ember.ArrayController.extend
  needs: ['topic']
  itemController: 'topicResource'
  descriptive: null
  isLoading: false

  displayingStandard: ( ->
    #TODO support multiple standards
    {title: @get('standard_idents')[0]}
  ).property('standard_idents')

  setStandardIdents: ( ->
     @set('standard_idents', @get('controllers.topic.standard_idents'))
  ).observes('controllers.topic.standard_idents')

  ###

    building query to pass thru Openedui.Resource
    to display in the result list
    @param idents {Array}
    @param descriptive {String}

  ###
  buildQuery: (idents, descriptive) ->
    #TODO support multiple standards
    return query =
      standard: idents[0]
      descriptive: descriptive

  ###

    Updating the content based on buildQuery results

  ###
  updateContent: ->
    unless @get('isLoading')
      @set('isLoading', true)
      query = @buildQuery(@get('standard_idents'), @get('descriptive'))
      model = Openedui.Resource.find(query)
      @set('content', model)

      model.one 'didLoad', =>
        @set('isLoading', false)

  actions:
    # main form search action or click 'search' button
    searchForm: ->
      @updateContent()

    # select standard drop-down
    selectStandard: (standard) ->
      @set('standard_idents', [standard.get('identifier')])
      @updateContent()




