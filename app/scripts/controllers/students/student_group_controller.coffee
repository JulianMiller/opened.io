Openedui.StudentGroupController = Ember.ObjectController.extend

  actions:
    leaveClass: (group)->
      if window.confirm "Do you want to leave '#{group.get('name')}' class? You can join later again with the same class code."
        group.deleteRecord()
        @get("store").commit()
        group.on 'didDelete', =>
          @transitionToRoute "student_groups"