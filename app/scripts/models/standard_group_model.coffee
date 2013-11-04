attr = DS.attr

Openedui.StandardGroup = DS.Model.extend
  name: attr('string')
  title: attr('string')
  count: attr('number')
  format_count: ( -> @get('count')?.toLocaleString() ).property('count')
