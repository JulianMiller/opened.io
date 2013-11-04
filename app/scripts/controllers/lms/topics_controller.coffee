###

  This controller supports list of topics in course page at LMS

###

Openedui.TopicsController = Ember.ArrayController.extend
  needs: ['course']
  itemController: 'topic'

  ###

    @method updateContent
    updating content, well actually just removing model at
    @startIndex and inserting at @endIndex
    used by drap and drop sorting view

    @param startIndex {Number}
    @param endIndex {Number}

  ###
  updateContent: (startIndex, endIndex) ->
    course = @get('controllers.course.content')
    #content = @get('content')

    @_swapper course.get('topics'), startIndex, endIndex, =>
      # set isDirty to the Course manually
      course.get('stateManager').goToState('updated')

  _swapper: (array, startIndex, endIndex, success) ->


    item = array.objectAt(startIndex)

    if endIndex > startIndex
      # if actualy has not moved item anywhere
      if Math.abs(startIndex - endIndex) == 1 then return false

      array.removeAt(startIndex)
      array.insertAt(endIndex - 1, item)

    else if endIndex < startIndex

      array.removeAt(startIndex)
      array.insertAt(endIndex, item)

    if success and typeof success == 'function' then success()

    return array

