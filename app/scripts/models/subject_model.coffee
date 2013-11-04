attr = DS.attr

Openedui.Subject = DS.Model.extend
  title: attr('string')
  count: attr('number')
  label: ( -> "#{@get('title')} (#{@get('count').toLocaleString()})"
  ).property('title', 'count')
