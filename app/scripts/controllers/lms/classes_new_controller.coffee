Openedui.ClassesNewController = Ember.ArrayController.extend
  needs: "course"

  actions:
    create: ->
      self = @
      if @get("name")
        # dont go further if "Create topic" button is disabled
        return if @get('isLoading')
        # set isLoading state in order to set disabled state on the button
        @set 'isLoading', true

        group = Openedui.Group.createRecord
          name: @get('name')
          course: @get("controllers.course.content")
        group.save().then ->
          Ember.run.next ->
            self.transitionToRoute('class', group.get("id"))
      else
        @set 'errorMessage', "Class name can't be blank"
