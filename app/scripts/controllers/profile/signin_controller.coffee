###

  Sign in controller

###

Openedui.ProfileSigninController = Ember.Controller.extend
  isLoading: false

  reset: ->
    @setProperties
      email: ''
      password: ''
      errorMessage: null

  actions:
    signin: ->
      self = this

      # dont go further if we sending already a request
      return if self.get('isLoading')
      self.set('isLoading', true)

      data = self.getProperties('email', 'password')

      # remove error message from previous attempts
      self.set('errorMessage', null)

      # use old style for ajax,
      # because promises don't work with mockjax plugin

      Ember.$.ajax(
        type: 'POST'
        url: Openedui.API.url.signin()
        data: data
        dataType: 'json'
        success: (response) ->
          Openedui.session.authenticate response.api_key.access_token, response.api_key.user_id
          self.transitionToRoute("/")
        error: ->
          self.set("errorMessage", "Invalid email or password.")
          Ember.$('input:first:visible').focus()
      ).always ->
        self.set('isLoading', false)

    signout: ->
      Openedui.session.reset()