Openedui.ProfileChangePasswordController = Ember.Controller.extend

  reset: ->
    @setProperties
      password:''
      password_confirmation: ''
      current_password: ''
      errorMessage:null

  actions:
    updatePassword: ->
      self = @
      data = @getProperties "password", "password_confirmation", "current_password"

      # request password reset instructions
      # TODO may be move to model as well
      Ember.$.ajax
        url: "#{Openedui.API.host}/users/update_password"
        data: data
        type: "PUT"
        dataType: "json"
      .done (response) ->
          self.transitionToRoute("profile.index")

      .fail (response) ->
          self.set('errorMessage', JSON.parse(response.responseText)['errors'])