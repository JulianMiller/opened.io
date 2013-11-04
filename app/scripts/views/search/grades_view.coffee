Openedui.ShowGradeItem = Ember.View.extend
  templateName: 'grades/grade'
  classNames: ['btn']
  tagName: 'button'
  attributeBindings: ['type', 'value']
  type: 'button'

Openedui.GradesView = Ember.CollectionView.extend
  classNames: ['btn-group', 'btn-radio-group']
  attributeBindings: ['data-toggle']
  'data-toggle': 'buttons-radio'
  itemViewClass: 'Openedui.ShowGradeItem'
  content: ['K','1','2','3','4','5','6','7','8','9','10','11','12','All']

  click: (event) ->
    $target = $(event.target)
    return unless $target.is('button')
    grade = $target.find('div').attr 'data-value'
    grades = Ember.A([grade])

    $target.parent().find('button').removeClass 'active'
    $target.addClass 'active'

    @set 'controller.selectedGrade', grades

  selectedGradeObserver: (->
    Ember.$('#grades button').removeClass('active') unless @get('controller.selectedGrade')?.length > 0
  ).observes('controller.selectedGrade.@each')
