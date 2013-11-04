###

  This controller supports single course at the LMS

###
Openedui.CourseController = Ember.ObjectController.extend
  isLoading: false

  # reverse isDirty property to corretly apply disabled attributes to buttons
  isNotDirty: (->
    !@.get('isDirty')
  ).property('isDirty').cacheable()

  # array of grades to populate select box
  grades: Openedui.grades

  ###

    Set standard_group attribute to the controller
    Can NOT use a model here, because standard_group at the course
    is not assosiated with belongsTo attribute and fields are different

    @method selectStandardGroupMethod
    @param standard_group {Openedui.StandardGroup}

  ###
  selectStandardGroupMethod: (standard_group) ->
    @set 'standard_group',
      title: standard_group.get('title')
      id: standard_group.get('id')

  # course actions for top buttons
  actions:
    deleteRecord: (course) ->
      #TODO wrap window.confirm in cool UI plugin
      confirm = window.confirm('You are about to delete the course and all its topics and classes, there is no undo. Do you want to proceed?')
      if (confirm)
        course.deleteRecord()
        course.get('transaction').commit()
        course.on 'didDelete', =>
          @transitionToRoute('courses')

    # discard changes at the model if we made some
    # unwanted editing
    discardChanges: (course) ->
      # discard changes on model if we only modify it
      if(course.get('isDirty'))
        course.rollback()

    saveChanges: (course) ->
      unless @get('isLoading')
        @set('isLoading', true)
        course.get('transaction').commit()
        course.one 'didUpdate', =>
          @set('isLoading', false)

    # action from selector of standard group
    selectStandardGroup: (standard_group) ->
      @selectStandardGroupMethod(standard_group)
