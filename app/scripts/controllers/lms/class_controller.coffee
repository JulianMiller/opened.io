Openedui.ClassController = Ember.ObjectController.extend
  needs: ['course']
  isLoading: false

  # reverse isDirty property to corretly apply disabled attributes to buttons
  isNotDirty: (->
    !@.get('isDirty')
  ).property('isDirty').cacheable()

  isZeroAssigned: ( ->
    @get('students.length') == 0
  ).property('students.@each')

  actions:
    delete: (group) ->
      #TODO wrap window.confirm in cool UI plugin
      confirm = window.confirm('You are about to delete the Class, there is no undo. Do you want to proceed?')
      if (confirm)
        self = this
        group.deleteRecord()
        @get('store').commit()
        group.one 'didDelete', ->
          self.transitionToRoute('classes')

    discardChanges: (group) ->
      # discard changes on model if we only modify it
      if(group.get('isDirty'))
        group.rollback()

    saveChanges: (group) ->
      group.get('transaction').commit()
