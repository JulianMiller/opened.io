Openedui.ResourcesSearchRouteMixin = Ember.Mixin.create
  model: (params,transition) ->
    # Reset the resource list filters
    @controllerFor('resources')?.resetParams()
    
    # setup the parameters for searching resources
    # includes parent route params if present
    controller = @controllerFor('search')
    key = @get 'resource_params'
    searchParams = {}
    searchParams[key] = transition.params[key + '_id']
    controller.set 'searchParams', searchParams
    model = Openedui.Resource.find searchParams
    controller.set 'controllers.resources.model', model
    Openedui.GaHelper.trackConversion 'search'
  renderTemplate: () ->
    @render 'resources/list',
      into: 'search'

Openedui.PlaylistsModalRouteMixin = Ember.Mixin.create
  actions:
    addToPlaylist: (resource) ->
      controller = @controllerFor('playlists_modal')
      controller.set "resource", resource
      controller.set "playlists", Openedui.Playlist.find()
      controller.set "message", ''

      @render 'playlists/modal',
        into: 'search'
        outlet: 'playlists'

    closePlaylistsModal: ->
      @render 'nothing',
        into: 'search'
        outlet: 'playlists'

Openedui.SearchRoute = Ember.Route.extend
  model: ->
    @controllerFor('search').set 'contributions', Openedui.Contribution.find()

Openedui.SearchIndexRoute = Ember.Route.extend
  redirect: -> @transitionTo 'standard_groups.index'

###
  Directory routes
###

Openedui.AreasIndexRoute = Ember.Route.extend Openedui.PlaylistsModalRouteMixin,
  model: -> 
    # This is an index route, initialize resources list to []
    controller = @controllerFor('search')
    controller.set 'searchParams', {}
    controller.set 'controllers.resources.model', Em.A([])
    controller.set 'controllers.resources.model.isLoaded', true
    Openedui.Area.find()
  renderTemplate: () ->
    @render 'resources/list',
      into: 'search'
      controller: @controllerFor('search').get('controllers.resources')
    @render 'areas/list',
      into: 'search'
      outlet: 'column'

Openedui.SubjectsRoute = Ember.Route.extend Openedui.PlaylistsModalRouteMixin,
  model: (params,transition) ->
    @controllerFor('search').set 'searchParams', {area: transition.params.area_id}
    Openedui.Subject.find 
      area: transition.params.area_id
  renderTemplate: () ->
    @render 'subjects/list',
      into: 'search'
      outlet: 'column'

Openedui.SubjectResourcesRoute = Ember.Route.extend Openedui.ResourcesSearchRouteMixin,  Openedui.PlaylistsModalRouteMixin,
  resource_params: 'subject'

###
  Standards routes
###

Openedui.StandardGroupsIndexRoute = Ember.Route.extend Openedui.PlaylistsModalRouteMixin,
  model: -> 
    # This is an index route, initialize resources list to []
    controller = @controllerFor('search')
    controller.set 'searchParams', {}
    controller.set 'controllers.resources.model', Em.A([])
    controller.set 'controllers.resources.model.isLoaded', true
    Openedui.StandardGroup.find()

  renderTemplate: () ->
    @render 'resources/list',
      into: 'search'
      controller: @controllerFor('search').get('controllers.resources')
    @render 'standard_groups/list',
      into: 'search'
      outlet: 'column'

Openedui.CategoriesRoute = Ember.Route.extend Openedui.PlaylistsModalRouteMixin,
  model: (params,transition) ->
    @controllerFor('search').set 'searchParams', {standard_group: transition.params.standard_group_id}
    Openedui.Category.find 
      standard_group: transition.params.standard_group_id

  renderTemplate: () ->
    @render 'categories/list',
      into: 'search'
      outlet: 'column'

Openedui.StandardsRoute = Ember.Route.extend Openedui.PlaylistsModalRouteMixin,
  model: (params,transition) ->
    @controllerFor('search').set 'searchParams', {category: transition.params.category_id}
    Openedui.Standard.find
      category: transition.params.category_id

  renderTemplate: () ->
    @render 'standards/list',
      into: 'search'
      outlet: 'column'

Openedui.StandardResourcesRoute = Ember.Route.extend Openedui.ResourcesSearchRouteMixin, Openedui.PlaylistsModalRouteMixin,
  resource_params: 'standard'
