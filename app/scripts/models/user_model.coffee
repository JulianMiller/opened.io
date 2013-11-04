Openedui.User = DS.Model.extend
  email: DS.attr("string")
  full_name: DS.attr("string")
  role: DS.attr("string")

  # created_at, intercom_user_hash and timestamp are needed for intercom.io analytics
  created_at: DS.attr('date')
  intercom_user_hash: DS.attr('string')
  intercom_app_id: DS.attr('string')
  timestamp: ( ->
    date = @get('created_at') or new Date()
    Math.round(date.getTime() / 1000)
  ).property()

  isTeacher: ( ->
    @get('role') is 'teacher'
  ).property('role')
  isStudent: ( ->
    @get('role') is 'student'
  ).property('role')
Openedui.User.titles = [ "Mr.", "Mrs.", "Ms.", "Dr."]