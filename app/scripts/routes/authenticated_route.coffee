###

  Authenticated route
  all routes requires an authentication should be extended from it

###
Openedui.AuthenticatedRoute = Ember.Route.extend()
###
  events:
    error: (reason, transition) ->
      if (reason.status is 401)
        @controllerFor("profile.signin").set("attemptedTransition", transition)
        @transitionTo('profile.signin')

###