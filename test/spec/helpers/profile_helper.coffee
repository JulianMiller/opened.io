
authenticate =  ->
  response =
    user:
      id: 777
      first_name:"Mary"
      last_name:"Smith"
      title:"Mrs."
      full_name:"Mrs. Mary Smith"
      email:"teacher@example.com"
      role:"teacher"

  Em.run ->
    Openedui.session.authenticate '0616cc104f34c9f4012d07abfa04a153', response.user.id