attr = DS.attr

Openedui.Area = DS.Model.extend
  title: attr('string')
  count: attr('number')
  label: ( -> "#{@get('title')} (#{@get('count').toLocaleString()})"
  ).property('title', 'count')
