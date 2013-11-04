###

  This components supports selector for groups/categories/standards

  Usage:

  Put in the template a special tag with parameters

  {{standards-selector
			value=value
      parentValue=standard_group
			selectValueText="Select Standard"
			changeValueText="Change Standard"
			startDataLevel=0
			endDataLevel=2
      navigationClick="selectStandard"
	}}

  @param value {Em.Object} is a current displaying value with attributes
      id: {Number}
      title: {String}

  @param parentValue (Optional) {Em.Object} value selected an the currentDataLevel - 1 with attributes
      id: {Number}
      title: {String}
  
  @param selectValueText {String}
  @param chongeValueText {String}
  
  @param startDataLevel {Number} the index of the model in 'models' attrubute to start with
  @param endDataLevel {Number} the index of the model in 'models' attrubute to end with

  @param navigationClick {String} if currentDataLevel equals endDataLevel the components
                                  sends an event to current controller method 'navigationClick'
  
  
  TODO:
    refactor
    write tests

###

Openedui.StandardsSelectorComponent = Ember.Component.extend

# open dialog or close
  open: false
  data: null

# models array each one is represents its index data-level
  models: [Openedui.StandardGroup, Openedui.Category, Openedui.Standard]

# current data level represents index from the 'models' property
  currentDataLevel: null
  selectedValues: Em.A()

  isLoading: (->
    return !@get('data.isLoaded')
  ).property('data.isLoaded')

# activate back link if we moved from start data level
  isBackLink: (->
    @get('currentDataLevel') > @get('startDataLevel')
  ).property('currentDataLevel')

  dialogTitle: ( ->
    dataLevel = @get('currentDataLevel')
    currentValue = @get('selectedValues').objectAt(dataLevel)
    if currentValue then currentValue.get('title') else currentValue = ''
  ).property('currentDataLevel')

  didInsertElement: ->
    # close dialog if clicking outside of the dialog
    Em.$('body').on 'click', =>
      if @get('open') then @closeDialog()

  willDestroyElement: ->
    Em.$('body').off 'click', =>
      if @get('open') then @closeDialog()

  click: (event) ->
    event.stopPropagation()

  loadData:( ->
    dataLevel = @get('currentDataLevel')

    # if we have parentValue - means we accessing not 0 level
    selectedValue = @get('selectedValues').objectAt(dataLevel)
    if selectedValue then id = selectedValue.get('id')

    switch dataLevel
      when 0
        @set 'data', @get('models')[dataLevel].find()

      when 1
        @set 'data', @get('models')[dataLevel].find
          standard_group: id
          grade: [@get('grade')]

      when 2
        @set 'data', @get('models')[dataLevel].find
          category: id

      else
        throw new TypeError "Wrong data level, should be in 0-2 range"
  ).observes('currentDataLevel')

  closeDialog: ->
    @set('open', false)

  openDialog: ->
    startDataLevel = @get('startDataLevel')
    @get('selectedValues')[startDataLevel] = @get('parentValue')

    @setProperties
      currentDataLevel: startDataLevel
      open: true

  actions:
    select: ->
      unless @get('open') then @openDialog() else @closeDialog()

    navigationClick: (item) ->
      # check if target data type is equal returned from the nav item
      # and populate event 'nagigationClick' outside of the component
      if item instanceof @get('models')[@get('endDataLevel')]
        @sendAction('navigationClick', item)
        @toggleProperty('open', true)

      # otherwise digging further in data levels
      else
        # save current item an next data level
        @get('selectedValues')[@get('currentDataLevel') + 1] = item
        @incrementProperty('currentDataLevel')

    back: ->
      @decrementProperty('currentDataLevel')

