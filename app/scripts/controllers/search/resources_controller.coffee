Openedui.ResourcesController = Ember.ArrayController.extend
  needs: ['search']
  content: []

  selectedGradeObserver: (->
    grades = @get 'controllers.search.selectedGrade'
    @set 'controllers.search.selectedGrade', undefined if grades?.contains('All')
    @updateParam 'selectedGrade', 'grade' 
  ).observes 'controllers.search.selectedGrade.@each'

  selectedContributionObserver: (->
    @updateParam 'selectedContribution', 'contribution_name'
  ).observes 'controllers.search.selectedContribution'

  selectedTypeObserver: (->
    @updateParam 'selectedType', 'resource_type'
  ).observes 'controllers.search.selectedType'

  ###

    update resource remote filter parameters
    `binding` is the bound handlebars property
    `key` is the ajax query parameter for the engine

    @method updateParam
    @param binding {String}
    @param key {String}

  ###
  updateParam: (binding, key) ->
    controller = @get 'controllers.search'
    params = controller.get 'searchParams'
    params[key] = controller.get(binding) or undefined
    controller.set 'searchParams', params
    @set 'content', Openedui.Resource.find(params)

  resetParams: ->
    @setProperties
      'controllers.search.selectedGrade': undefined
      'controllers.search.selectedContribution': undefined
      'controllers.search.selectedType': undefined

