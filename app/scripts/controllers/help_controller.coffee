Openedui.HelpController = Ember.ArrayController.extend
  needs: ['application']

  isSignedIn: Ember.computed.alias("controllers.application.isSignedIn")

  ask: ->
    self = @
    @set('notice', null)

    email = if @get("isSignedIn")
        Openedui.session.get("apiKey.user.email")
      else
        @get('email')
    if !!@get("question") and !!email
      $.ajax(
        type: 'POST'
        url: Openedui.API.url.help()
        data:
          email: email
          question: @get('question')
        dataType: 'json'
        success: (response) ->
          self.set('notice', 'Thank you for your question')
          self.set('question', '')
        error: ->
          Ember.$('textarea').focus()
      )