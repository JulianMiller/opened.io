Openedui.SearchController = Ember.Controller.extend
  needs: ['standard_groups.index', 'categories', 'standards', 'resources']

  actions:
    keywordSearch: ->
      Openedui.GaHelper.trackConversion 'search'
      params = @get('searchParams') or {}
      params['descriptive'] = @get('descriptive')
      model = Openedui.Resource.find params
      @set 'controllers.resources.content', model
