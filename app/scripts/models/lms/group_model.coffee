attr = DS.attr

Openedui.Group = DS.Model.extend
  name: attr('string')
  code: attr('string')
  course: DS.belongsTo('Openedui.Course')
  students: DS.hasMany('Openedui.User')

Openedui.Store.registerAdapter 'Openedui.Group', Openedui.LMSadapter

Openedui.LMSadapter.map 'Openedui.Group',
  students:
    embedded: 'always'
