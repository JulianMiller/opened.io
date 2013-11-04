###

  Setups for Openedui Application

###
CONFIG = window.CONFIG || {}
Openedui = window.Openedui = Ember.Application.create
  grades: ['K', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12']

  LOG_STACKTRACE_ON_DEPRECATION: CONFIG.LOG_STACKTRACE_ON_DEPRECATION
  LOG_BINDINGS: CONFIG.LOG_BINDINGS
  LOG_TRANSITIONS: CONFIG.LOG_TRANSITIONS
  LOG_TRANSITIONS_INTERNAL: CONFIG.LOG_TRANSITIONS_INTERNAL
  LOG_VIEW_LOOKUPS: CONFIG.LOG_VIEW_LOOKUPS
  LOG_ACTIVE_GENERATION: CONFIG.LOG_ACTIVE_GENERATION

  ready: ->
    $(document).ajaxError (event, request, settings) =>
      ###
        Can make an additional condition && !["/users"].contains(settings.url)
        to exclude specific resources from tronsitionTo
      ###
      if request.status == 401
        Openedui.session.reset() if Openedui.session.get("apiKey")
        window.location.replace '#/profile/signin'

###

  Add support of required and autofocus attributes to Ember form view helpers e.g.
  {{view Ember.TextField valueBinding="email" type="email" autofocus="true" required="true"}}

###
Ember.TextSupport.reopen
  attributeBindings: ["required", "autofocus", "autocorrect", "autocomplete"]

###

  Openedui.API object

###

Openedui.API =
  version: 2
  resources_limit: 5
  host: CONFIG.API_HOST

  url:
    # a hardcoded api urls
    signin: -> "#{Openedui.API.host}/session"
    signup: -> "#{Openedui.API.host}/users"
    help: -> "#{Openedui.API.host}/support/help"
    playlists: -> "#{Openedui.API.host}/users/playlists"
    contributions: -> "#{Openedui.API.host}/contributions.json"
    rating: -> "#{Openedui.API.host}/resources/rate.json"
    standard_groups: "/standard_groups"
    recommended: "/resources/recommend.json"
    areas: "/areas"
    subjects: "/subjects"
    categories: "/categories"
    standards: "/standards"
    resources: "/resources"
    yourCourses: "/teachers"
    topics: "/topics"
