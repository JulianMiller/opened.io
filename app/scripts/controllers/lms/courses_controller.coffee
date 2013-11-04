Openedui.CoursesController = Ember.ArrayController.extend
  sortProperties: ['created_at']
  sortAscending: false
  #filteredContent: ( ->
  #  @get('content').filter( (item, index) ->
  #    !(item.get('isDirty'))
  #  )
  #).property('content.@each')


