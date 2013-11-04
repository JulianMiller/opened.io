###

  Sign up tests
  TODO fix on travis

###

userData = {
  email: 'teacher@example.com'
  password: 'password'
  password_confirmation: 'password'
  first_name: 'John'
  last_name:  'Bull'
}

password = '.ts-signup-password'
passwordConfirmation = '.ts-signup-password'
email    = '.ts-signup-email'
firstName = '.ts-signup-firstName'
lastName = '.ts-signup-lastName'
classCode = '.ts-signup-code'
button   = '.ts-signup-signupButton'
profileLink = '.ts-profileButton'

module 'Sign up',
  setup: ->
    Em.run ->
      Openedui.reset()
      Openedui.deferReadiness()

#  teardown: ->
#    $.mockjaxClear()
#    localStorage.clear()
#    Ember.testing = false

test 'We got inputs for email and password', ->
  expect(5)
  Ember.run Openedui, 'advanceReadiness'

  visit('/profile/signup').then(->
    passwordInput = find(password)
    passwordConfirmationInput = find(passwordConfirmation)
    emailInput = find(email)
    firstNameInput = find(firstName)
    lastNameInput = find(lastName)

    equal(passwordInput.length, 1, 'We have password field')
    equal(passwordConfirmationInput.length, 1, 'We have password confirmation field')
    equal(emailInput.length, 1, 'We have email field')
    equal(firstNameInput.length, 1, 'We have last name field')
    equal(lastNameInput.length, 1, 'We have first name field')
  )

test 'Sign up with correct user info', ->
  expect(3)
  #response = {"api_key":{"id":15,"access_token":"0616cc104f34c9f4012d07abfa04a154","user_id":1, "role": "teacher"}}
  #stubEndpointForHttpRequest(API.url.signup(), response, 'POST')
  Ember.run Openedui, 'advanceReadiness'

  visit('/profile/signup').then( ->
    equal($(button).length, 1 , 'See submit button')

    ok(!Openedui.session.apiKey, "session not opened")
    equal($(profileLink).length, 0, 'Dont see profile button')

    #fillIn password, userData.password
    #fillIn passwordConfirmation, userData.password_confirmation
    #fillIn(email, userData.email)
    #fillIn firstName, userData.first_name
    #fillIn lastName, userData.last_name

    #click(button)
  ).then(->
    # dont use 'mising' as a assertion, its kind of weird
    #ok(Openedui.session.apiKey, "session was opened")
    #equal Openedui.session.get("apiKey.user.id"), 1, "user_id is 1"
    #equal($(button).length, 0 , 'We moved away from sign up page')
    #equal($(profileLink).length, 1, 'see profile button')
  )

#test 'Sign in with wrong credentials', ->
#  expect(3)
#
#  $.mockjax
#    url: API.url.signup()
#    dataType: 'json',
#    responseText: '{"errors":"Password doesn\'t match confirmation"}',
#    proxyType: "POST"
#    status: 422
#
#  visit('/profile/signup').then( ->
#    fillIn password, userData.password
#    fillIn passwordConfirmation, 'passwd'
#    fillIn(email, userData.email)
#    fillIn firstName, userData.first_name
#    fillIn lastName, userData.last_name
#
#    click(button)
#  ).then(->
#    # dont use 'mising' as a assertion, its kind of weird
#    equal($(button).length, 1 , 'We stay on sign up page')
#    equal($(".alert-error").text(), "Password doesn\'t match confirmation", 'See an error message')
#    ok(!Openedui.session.apiKey, "session not opened")
#  )



