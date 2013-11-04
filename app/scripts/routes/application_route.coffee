Openedui.ApplicationRoute = Ember.Route.extend

  init: ->
    @_super()
    Openedui.session = Openedui.Auth.create()

  actions:
    signout: ->
      Openedui.session.reset()
      @transitionTo('profile.signin')

