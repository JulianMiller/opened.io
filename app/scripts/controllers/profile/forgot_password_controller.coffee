Openedui.ProfileForgotPasswordController = Ember.Controller.extend
  isLoading: false
  isRequested: false

  actions:
    requestPasswordReset: ->
      return if @get('isLoading')
      @set 'isLoading', true

      self = @
      data = @getProperties "email"

      # request password reset instructions
      Ember.$.post("#{Openedui.API.host}/users/password", data)
        .done (response) ->
          self.set 'isRequested', true

        .fail (response) ->
          self.set('errorMessage', JSON.parse(response.responseText)['errors'])

        .always ->
          self.set 'isLoading', false