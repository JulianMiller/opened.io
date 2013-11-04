Openedui.ProfileSignupController = Ember.Controller.extend
  isLoading: false

  actions:
    signup: ->
      self = @

      # dont go further if we sending already a request
      return if self.get('isLoading')
      self.set('isLoading', true)

      @set "role", @get("activeTab")
      data = @getProperties "email", "password", "password_confirmation", "title", "first_name", "last_name", "role", "code"

      # remove error message from previous attempts
      @set('errorMessage', null)

      # create user and get the token from api
      Ember.$.ajax(
        url: Openedui.API.url.signup()
        data: data
        type: "POST"
        dataType: 'json'
        success: (response) ->
          Openedui.session.authenticate response.api_key.access_token, response.api_key.user_id
          self.transitionToRoute("/")
        error: (response) ->
          self.set("errorMessage", JSON.parse(response.responseText)['errors'])
      ).always ->
        self.set('isLoading', false)