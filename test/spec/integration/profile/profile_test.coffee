
module 'Profile',
  setup: ->
    Em.run ->
      $.mockjaxClear()
      localStorage.clear()
      Openedui.reset()
      Openedui.deferReadiness()

  #teardown: ->
  #  Openedui.reset()
  #  Ember.testing = false
  #  localStorage.clear()

test "index page without login", ->
  expect 2
  Ember.run Openedui, 'advanceReadiness'
  ok !Openedui.session.apiKey, "empty session"

  Ember.run Openedui, 'advanceReadiness'
  visit('/profile/index').then ->
    equal($('.ts-signin-signinButton').length, 1, 'Sign In link exists')

test "index page with login", ->
  expect 4

  Ember.run Openedui, 'advanceReadiness'
  authenticate()

  ok Openedui.session.apiKey, "session exists"
  visit('/profile/index').then ->
    equal $('.ts-profileButton').length, 1, 'see profile button'
    equal $(".ts-userProfile dd").eq(0).text(), 'Mrs. Mary Smith'
    equal $(".ts-userProfile dd").eq(1).text(), 'teacher@example.com'

test "Change password page", ->
  expect 5

  Ember.run Openedui, 'advanceReadiness'
  authenticate()
  visit('/profile/index').then ->
    equal($('.ts-profile-changePasswordLink').length, 1, 'Change password link exists.')
    click('.ts-profile-changePasswordLink')
  .then ->
      equal $('.ts-changePassword-password').length, 1, 'see password field'
      equal $('.ts-changePassword-passwordConfirmation').length, 1, 'see password confirmation field'
      equal $('.ts-changePassword-currentPassword').length, 1, 'see current password field'
      equal $('.ts-changePassword-submitButton').length, 1, 'see button'

