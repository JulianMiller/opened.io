###

  This controller supports creation of new course on LMS

###

Openedui.CoursesNewController = Ember.ObjectController.extend
  grades: Openedui.grades
  needs: ['course']
  isLoading: false

  actions:
    createRecord: (course) ->
      # dont go further if "Create Course" button is disabled or title is empty
      if @get('title') and not @get('isLoading')

        @setProperties
          'isLoading': true
          'errorMessage': null

        course = @get('content')
        @get('store').commit()

        course.one 'didCreate', =>
          Ember.run.next =>
            @transitionToRoute('topics', course.get('id'))
      else
        @set 'errorMessage', "Course Name can't be blank"

    # action from standard group selector, reusing Course controller method
    selectStandardGroup: (standard_group) ->
      @get('controllers.course').selectStandardGroupMethod.call(this, standard_group)


