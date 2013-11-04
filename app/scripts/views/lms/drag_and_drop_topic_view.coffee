###

  Drag and drop mixings for getting started with dNd elements

###

DragNDrop = Ember.Namespace.create()

DragNDrop.cancel = (event) ->
  event.preventDefault()
  return false

###

  Mixin for  any draggable elements

###
DragNDrop.Draggable = Ember.Mixin.create
  attributeBindings: 'draggable'
  draggable: 'true'
  dragStart: (event) ->
    dataTransfer = event.originalEvent.dataTransfer
    dataTransfer.setData('Text', this.get('elementId'))

###

  Mixin for any droppable elements

###
DragNDrop.Droppable = Ember.Mixin.create
  dragEnter: DragNDrop.cancel
  dragOver: DragNDrop.cancel
  drop: (event) ->
    event.preventDefault()
    return false

###

  Placeholder for sortable dNd
  triggering callback at removing its dom at droping

###

DragNDrop.Placeholder = Ember.View.extend DragNDrop.Droppable,
    classNames: ['dNd-placeholder']
    tagName: 'li'
    callback: ->
      throw new Error 'pass callback parameter at the create()'

    drop: (event) ->
      event.preventDefault()
      if typeof @get('callback') == 'function' then @get('callback').apply(this.get('parentView'))

      @$().remove()
      return false


###

  Sortable collection view for sorting any list or grids

  usage

  {{view Openedui.SortableView
	  contentBinding=controller
	  tagName='ul'
	  class='list__blocks'

	  itemViewTemplateName='topics/test'
	  itemViewCssClass='list__blocks__item'
  }}


###

Openedui.SortableView = Ember.CollectionView.extend
  itemViewClass: 'Openedui.SortableItemView'
  itemViewTemplateName: null # template for child views
  draggingItem: null
  draggingIndex: null
  placeholder: null

  didInsertElement: ->
    # create a placeholder for dropping an item
    @set 'placeholder', @pushObject DragNDrop.Placeholder.create
      callback: @_updateContent

    # hide it for now
    @get('placeholder').one 'didInsertElement', ->
      @$().remove()


  # this method got triggered after dropping
  _updateContent: ->
    endIndex = @get('placeholder').$().index()
    startIndex = @get('draggingIndex')

    # trigger current controller method updateContent
    @get('controller').updateContent(startIndex, endIndex, @get('draggingItem.content.model'))

###

  Item view for sortable collection
  do NOT use it without parent CollectionView!

###
Openedui.SortableItemView = Ember.View.extend DragNDrop.Draggable,
  classNames: ['list__blocks__item']
  draggingClassName: 'dNd-dragging'

  # pick the template name from parent collectionView
  templateName: ( ->
    @get('parentView.itemViewTemplateName')
  ).property()

  # pick the placeholder from the parent collectionView
  placeholder: (->
    @get('parentView.placeholder')
  ).property()

  dragStart: (event) ->
    dt = event.originalEvent.dataTransfer
    dt.effectAllowed = 'move'
    dt.setData('Text', @get('elementId'))
    @$().addClass(@get('draggingClassName'))

    # update parent dragging index and element
    @get('parentView').setProperties
      'draggingIndex': @get('parentView').indexOf(this)
      'draggingItem': this

    # set height to placeholder equal to current item
    @get('placeholder').$().height( @$().height() - 4)

  dragEnd: (event) ->
    @$().removeClass(@get('draggingClassName')).show()
    @get('placeholder').$().remove()

  dragOver: Ember.aliasMethod('dragging')
  dragEnter: Ember.aliasMethod('dragging')

  dragging: (event) ->
    event.preventDefault()
    event.originalEvent.dataTransfer.dropEffect = 'move'

    @get('parentView.draggingItem').$().hide()

    #figure aut there to draw a placeholder based on indexes
    direction = if @get('placeholder').$().index() < @$().index() then 'after' else 'before'
    @$()[direction](@get('placeholder').$())





