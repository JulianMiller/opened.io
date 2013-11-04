Openedui.ApplicationController = Ember.Controller.extend

  currentUser: ( ->
    Openedui.session.get("apiKey.user")
  ).property("Openedui.session.apiKey")

  isSignedIn: ( ->
    Openedui.session.isAuthenticated()
  ).property("Openedui.session.apiKey")

# sends data to intercom.io
  sessionObserver: ( ->
    if @get('currentUser')
      window.intercomSettings =
        email: @get('currentUser.email')
        created_at: @get('currentUser.timestamp')
        name: @get('currentUser.full_name')
        user_id: @get('currentUser.id')
        app_id: @get('currentUser.intercom_app_id')
        user_hash: @get('currentUser.intercom_user_hash')
      # this is modified script from intercom, onload event handling was replaced by l()
      `(function(){var w=window;var ic=w.Intercom;if(typeof ic==="function"){ic('reattach_activator');ic('update',intercomSettings);}else{var d=document;var i=function(){i.c(arguments)};i.q=[];i.c=function(args){i.q.push(args)};w.Intercom=i;function l(){var s=d.createElement('script');s.type='text/javascript';s.async=true;s.src='https://static.intercomcdn.com/intercom.v1.js';var x=d.getElementsByTagName('script')[0];x.parentNode.insertBefore(s,x);} l();};})()`


  ).observes('currentUser.email')


