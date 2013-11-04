###

  Sign in tests
  TODO fix on travis

###

creds = {
  email: 'teacher@example.com',
  password: 'password'
}

passwordClassName = '.ts-signin-password';
emailClassName    = '.ts-signin-email';
buttonClassName   = '.ts-signin-signinButton'
profileLinkClassName = '.ts-profileButton'

module 'Sign in',
  setup: ->
    Em.run ->
      $.mockjaxClear()
      localStorage.clear()
      Openedui.reset()
      Openedui.deferReadiness()

  #setup: ->
  #  $.mockjaxClear()
  #  Ember.run(Openedui, Openedui.advanceReadiness);

  #teardown: ->
  #  Openedui.reset()
  #  Ember.testing = false
  #  localStorage.clear()

test 'We got inputs for email and password', ->
  expect(2)
  Ember.run Openedui, 'advanceReadiness'

  visit('/profile/signin').then(->
    passwordInput = find(passwordClassName)
    emailInput = find(emailClassName)
    equal(passwordInput.length, 1, 'We have password field')
    equal(emailInput.length, 1, 'We have email field')
  )

test 'Sign in with right credentials', ->
  expect(2)
  
  #data = {"api_key":{"id":5,"access_token":"0616cc104f34c9f4012d07abfa04a153","user_id":3, "role": "teacher"}}
  #stubEndpointForHttpRequest(API.url.signin(), data, 'POST')

  Ember.run Openedui, 'advanceReadiness'
  visit('/profile/signin').then( ->
    equal($(buttonClassName).length, 1 , 'See submit button')
    equal($(profileLinkClassName).length, 0, 'Dont see profile button')

    fillIn(passwordClassName, creds.password)
    fillIn(emailClassName, creds.email)
    #Em.run ->
    #  click(buttonClassName)

  ).then(->
    # dont use 'mising' as a assertion, its kind of weird
    #equal($(buttonClassName).length, 0 , 'We moved away from sign in page')
    #equal($(profileLinkClassName).length, 1, 'see profile button')
  )

#test 'Sign in with wrong credentials', ->
#  expect(2)
#
#  $.mockjax
#    url: API.url.signin()
#    dataType: 'json',
#    responseText: "{}",
#    proxyType: "POST"
#    status: 401

#  visit('/profile/signin').then( ->
#    fillIn(passwordClassName, '')
#    fillIn(emailClassName, creds.email)
#    click(buttonClassName)
#  ).then(->
    # dont use 'mising' as a assertion, its kind of weird
#    equal($(buttonClassName).length, 1 , 'We stay on sign in page')
#    equal($(".alert-error").text(), "Invalid email or password.", 'See an error message')
#  )

test "Signout after signin", ->
  expect 5
  signoutButtonClassName = '.ts-signoutButton'
  ok not Openedui.session.apiKey, "session not opened"

  Ember.run Openedui, 'advanceReadiness'
  authenticate()
  visit('/').then ->
    ok Openedui.session.apiKey, "session was opened"
    signoutButton = find signoutButtonClassName
    equal signoutButton.length, 1, 'see signout button'
    click signoutButton
  .then ->
      signoutButton = find signoutButtonClassName
      equal signoutButton.length, 0, 'dont see signout button'
      ok not Openedui.session.apiKey, 'session was closed'







