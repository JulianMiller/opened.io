# profile
Openedui.ProfileSigninRoute = Ember.Route.extend
  setupController: (controller, context) ->
    # reset controller at signin page to remove previous signin attepms
    controller.reset()

Openedui.ProfileIndexRoute = Openedui.AuthenticatedRoute.extend
  model: ->
    Openedui.session.get("apiKey.user")

  redirect: ->
    unless @modelFor('profile.index')
      @transitionTo 'profile.signin'

Openedui.ProfileChangePasswordRoute = Openedui.AuthenticatedRoute.extend
  setupController: (controller, context) ->
    # reset controller at sigin page to remove previous signin attepms
    controller.reset()

Openedui.ProfileResetPasswordRoute = Ember.Route.extend
   setupController: (controller, params) ->
     controller.set "reset_password_token", params.reset_password_token

Openedui.ProfileSignupRoute = Ember.Route.extend

  actions:
    selectTab: (name) ->
      @controllerFor("profile.signup").set "activeTab", name
      @render "profile/_#{name}_fields",
        into: "profile.signup"
        outlet: "tab"

  setupController: (controller) ->
    controller.set "activeTab", "teacher"

  renderTemplate: ->
    @render()
    @render "profile/_teacher_fields",
      outlet: "tab"
      into: "profile.signup"

