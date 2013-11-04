Openedui.ResourceRoute = Ember.Route.extend
  activate: ->
    @set 'goBackPath', window.location.href

  model: (params) ->
    Openedui.Resource.find params.id

  renderTemplate: ->
    @render 'resources/modal', ->
      outlet: 'modal'

  afterModel: (resource, transition) ->
    # before rendering template
    # figure out if current modes is embeddable or not, if not open it to new window.
    isEmbeddable = resource.get('embeddable')
    unless isEmbeddable
      transition.abort()
      window.open(resource.get('safe_url'), '_blank')

  actions:
    closeModal: ->
      window.location.href = @get 'goBackPath'

Openedui.ShareResourceRoute = Ember.Route.extend
  renderTemplate: ->
    @render 'resources/share'

  model: (params) ->
    Openedui.Resource.find params.resource_id
