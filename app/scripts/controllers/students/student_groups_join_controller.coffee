Openedui.StudentGroupsJoinController = Ember.Controller.extend
  needs: 'student_groups'
  reset: ->
    @set 'code', null
    @set 'errorMessage', null

  actions:
    joinClass: ->
      if @get("code")
        # client side validation TODO refactor for something less verbose
        if @get('controllers.student_groups.content').findBy('code', @get('code'))
          @set 'errorMessage', "You've already joined this class"
          return

        # dont go further if "Join Class" button is disabled
        return if @get('isLoading')
        # set isLoading state in order to set disabled state on the button
        @set 'isLoading', true

        group = Openedui.StudentGroup.createRecord code: @get('code')
        group.save().then =>
          Ember.run.next =>
            @transitionToRoute 'student_group', group.get("id")
            @set 'isLoading', false

        group.on "becameError", (e) =>
          @set 'errorMessage', "We can't find any class for this code"
          @set 'isLoading', false
          @get('controllers.student_groups.content').removeObject(group)

      else
        @set 'errorMessage', "Class code can't be blank"
