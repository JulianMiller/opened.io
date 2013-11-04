Openedui.Router.map ->
  @route 'help'

  # lms routes
  @resource 'courses', ->
    @route 'new'
    @resource 'course', path: '/:course_id', ->

      @resource 'student_view', ->

      @resource 'topics', ->
        @route 'new'
        @resource 'topic', path: '/:topic_id', ->
          @resource 'assigned'
          @resource 'recommended'
          @resource 'topic_playlist_resources', path: '/from_playlist'
          @resource 'topic_search_resources', path: '/search'

      @resource 'classes', ->
        @route 'new'
        @resource 'class', path: '/:class_id', ->


  @resource 'student_groups', path: '/classes', ->
    @resource 'student_group', path: '/:group_id'
    @route 'join'

  @route 'about'

  # playlists
  @resource 'playlists', ->
    @route 'new'
    @resource 'playlist', path: '/:playlist_id'

  @resource 'shared_playlist', path: '/shared-playlist/:slug'

  # user profile
  @resource 'profile', ->
    @route 'index'
    @route 'change_password'
    @route 'signin'
    @route 'signup'
    @route 'forgot_password'
    @route 'reset_password', path: "/reset_password/:reset_password_token"
    @route 'signout'
    @route 'password'

  # standards
  @resource 'search', ->
    @resource 'standard_groups', path: '/standard_groups', ->
      @resource 'standard_group', path: '/:standard_group_id', ->
        @resource 'categories', path: '/categories', ->
          @resource 'category', path: '/:category_id', ->
            @resource 'standards', path: '/standards', ->
              @resource 'standard', path: '/:standard_id', ->
                @resource 'standard_resources', path: '/resources', ->

    @resource 'areas', path: '/areas', ->
      @resource 'area', path: '/:area_id', ->
        @resource 'subjects', path: '/subjects', ->
          @resource 'subject', path: '/:subject_id', ->
            @resource 'subject_resources', path: '/resources', ->

    @resource 'resources', ->
      @resource 'resource', path: '/:resource_id', ->

  @resource 'share_resource', path: '/share/:resource_id'

Ember.Router.reopen
  didTransition: (infos) ->
    @_super infos
    return if window._gaq is undefined

    Ember.run.next ->
      _gaq.push ['_trackPageview', window.location.hash.substr(1)]
