attr = DS.attr

Openedui.Course = DS.Model.extend
  created_at: attr('date')
  updated_at: attr('date')
  grade: attr('string')
  title: attr('string')
  description: attr('string')
  topics: DS.hasMany('Openedui.Topic')
  groups: DS.hasMany('Openedui.Group')
  standard_group: attr('object')

Openedui.Store.registerAdapter 'Openedui.Course', Openedui.LMSadapter