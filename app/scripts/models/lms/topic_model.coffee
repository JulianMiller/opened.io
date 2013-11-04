attr = DS.attr

Openedui.Topic = DS.Model.extend
  description: attr('string')
  title: attr('string')
  course: DS.belongsTo('Openedui.Course')
  resources: DS.hasMany('Openedui.Resource')
  standard_idents: attr('array')

  isZeroAssigned: ( ->
    @get('resources.length') == 0
  ).property('resources.@each')

  displayingStandard: ( ->
    return Em.Object.create
      title: @get('standard_idents')[0]
      id: null
  ).property('standard_idents.@each')

  standardGroup:( ->
    return @get('course.standard_group')
  ).property('course.standard_group')

  grade:( ->
    return @get('course.grade')
  ).property('course.grade.@each')

Openedui.Store.registerAdapter 'Openedui.Topic', Openedui.LMSadapter.extend

  findMany: (store, type, ids, owner) ->
    root = this.rootForType(type)
    adapter = this
    ids = this.serializeIds(ids)

    return this.ajax(this.buildURL(root), "GET",
      data:
        course_id: owner.id
    ).then( (json) ->

      adapter.didFindMany(store, type, json)

    ).then(null, error);

    error = (text) ->
      throw new Error text




