Openedui.StudentGroup = DS.Model.extend
  name: DS.attr('string')
  code: DS.attr('string')
  course_title: DS.attr('string')
  teacher: DS.attr('string')
  course: DS.belongsTo('Openedui.Course')

Openedui.Store.registerAdapter 'Openedui.StudentGroup', DS.RESTAdapter.extend
  url: "#{Openedui.API.host}/students"

DS.RESTAdapter.map 'Openedui.StudentGroup',
  course:
    embedded: 'load'