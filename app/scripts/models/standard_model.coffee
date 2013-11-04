attr = DS.attr

Openedui.Standard = DS.Model.extend
  identifier: attr('string')
  title: attr('string')
  count: attr('number')
  label: ( -> "#{@get('identifier')}: #{@get('title')}"
  ).property('identifier', 'title')
  format_count: ( -> @get('count').toLocaleString() ).property('count')

Openedui.Standard.reopenClass
  search: (identifier,callback) ->
    $.ajax
      type: 'GET'
      url: Openedui.API.host + Openedui.API.url.standards + '/search.json'
      data: {identifier: identifier}
    .then (result) ->
      callback result.standard
