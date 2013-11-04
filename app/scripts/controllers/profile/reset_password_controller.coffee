Openedui.ProfileResetPasswordController = Ember.Controller.extend
  isLoading: false

  actions:
    resetPassword: ->
      return if @get('isLoading')
      @set 'isLoading', true

      self = @
      data = @getProperties "password", "password_confirmation", "reset_password_token"

      # request password reset instructions
      Ember.$.ajax(
        url: "#{Openedui.API.host}/users/password"
        data: data
        type: "PUT"
        success: (response) ->
            Openedui.session.authenticate response.api_key.access_token, response.api_key.user_id
            self.transitionToRoute("index")

        error: (response) ->
            self.set('errorMessage', JSON.parse(response.responseText)['errors'])
      ).always ->
        self.set 'isLoading', false