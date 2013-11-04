Openedui.Auth = Ember.Object.extend

  # Load the current user if the cookies exist and is valid
  init: ->
    @_super()
    accessToken = localStorage.access_token
    authUserId = localStorage.auth_user
    @authenticate(accessToken, authUserId)  if not Ember.isEmpty(accessToken) and not Ember.isEmpty(authUserId)

  # Determine if the user is currently authenticated.
  isAuthenticated: ->
    not Ember.isEmpty(@get("apiKey.accessToken")) and not Ember.isEmpty(@get("apiKey.user"))

  # Authenticate the user. Once they are authenticated, set the access token to be submitted with all
  # future AJAX requests to the server.
  authenticate: (accessToken, userId) ->
    $.ajaxSetup headers:
      Authorization: "Token token=#{accessToken}"

    user = Openedui.User.find(userId)
    @set "apiKey", Openedui.ApiKey.create
      accessToken: accessToken
      user: user

  # Log out the user
  reset: ->
    Openedui.__container__.lookup("route:application").transitionTo "profile.signin"
    Ember.run.sync()

    Ember.run.next @, =>
      @set "apiKey", null
      $.ajaxSetup headers:
        Authorization: "Token token=none"
      Openedui.reset()

  # Ensure that when the apiKey changes, we store the data in cookies in order for us to load
  # the user when the browser is refreshed.
  apiKeyObserver: ( ->
    if Ember.isEmpty(@get("apiKey"))
      localStorage.removeItem "access_token"
      localStorage.removeItem "auth_user"
    else
      localStorage.setItem "access_token", @get("apiKey.accessToken")
      localStorage.setItem "auth_user", @get("apiKey.user.id")
  ).observes("apiKey")

