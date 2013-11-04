###

  This controller supports creation of new topic in LMS

###
Openedui.TopicsNewController = Ember.ObjectController.extend
  needs: ["course", "topic"]

  actions:
    createRecord: (topic) ->
#      debugger
      # dont go further if title is empty
      if @get('title')
        return if @get('isLoading')
        # set isLoading state in order to set disabled state on the button
        course = @get("controllers.course.content")
        @get('store').commit()

        topic.one 'didCreate', =>
          #hacking around ember-data issue
          #https://github.com/emberjs/data/issues/405#issuecomment-18726035
          Ember.run.next =>
            @transitionToRoute('topic', topic.get('id'))
            course.reload()

      else
        @set "errorMessage", "Topic Name can't be blank"

    selectStandard: (standard) ->
      @get('controllers.topic').selectStandardMethod.call(this, standard)