questionField = ".ts-help-question"
emailField = ".ts-help-email"
submitButton = ".ts-help-button"
notice = ".ts-help-notice"

module 'Help',
  setup: ->
    Em.run ->
      Openedui.reset()
      Openedui.deferReadiness()

#  teardown: ->
#    Openedui.reset()
#    Ember.testing = false
#    localStorage.clear()

test "not authenticated", ->
  expect 1
  #stubEndpointForHttpRequest(API.url.help(), null, 'POST')
  Ember.run Openedui, 'advanceReadiness'
  visit('/help').then ->
    equal $(questionField).length, 1, 'has question field'
    #fillIn questionField, "A question"
    #fillIn emailField, "vasya@example.com"
    #click submitButton
  #.then ->
  #  equal $(notice).length, 1, "get notice"
  #  equal $(questionField).text(), "", "question was reset"

test "not authenticated, did not fill in email", ->
  expect 1
  Ember.run Openedui, 'advanceReadiness'

  visit('/help').then ->
    equal $(questionField).length, 1, 'has question field'
    #fillIn questionField, "A question"
    #click submitButton
  #.then ->
  #    equal $(notice).length, 0, "get notice"
  #    equal $(questionField).val(), "A question", "question was not reset"

test "authenticated user", ->
  expect 1
  #stubEndpointForHttpRequest(API.url.help(), null, 'POST')
  #authenticate()
  Ember.run Openedui, 'advanceReadiness'
  visit('/help').then ->
    equal $(questionField).length, 1, 'has question field'
    #fillIn questionField, "A question"
    #click submitButton
  #.then ->
  #    equal $(notice).length, 1, "get notice"
  #    equal $(questionField).text(), "", "question was reset"