###

  setting up the adapter, checking if we in the testing mode, so use static Fixtures
  instead of RESTAdapter

###
Openedui.Adapter =  DS.RESTAdapter

Openedui.Store = DS.Store.extend
  revision: 13
  adapter: Openedui.Adapter


DS.RESTAdapter.reopen
  url: Openedui.API.host
  buildURL: (record, suffix) ->
     @_super(record, suffix) + ".json"

###

  Configure plurals for models

###
DS.RESTAdapter.configure 'plurals',
  category: 'categories'

###

  Custom RESTAdapter transforms

###
DS.RESTAdapter.registerTransform 'array',
  serialize: (data) ->
    data
  deserialize: (data) ->
    data

DS.RESTAdapter.registerTransform 'object',
  serialize: (data) ->
    data
  deserialize: (data) ->
    Em.Object.create(data)


###

  Headers we use for all ajax requests

###
$.ajaxSetup headers:
  Accept: 'application/json, text/javascript'

###

  Create an extension of RESTadapter for lms

###
Openedui.LMSadapter = Openedui.Adapter.extend
  namespace: 'teachers'

  serializer: DS.RESTSerializer.extend
    addHasMany: (hash, record, key, relationship) ->
      # correcty applying resources hasMany in the topic
      ids = record.get(relationship.key).map (item) ->
        return item.get('id');

      hash[key] = ids;