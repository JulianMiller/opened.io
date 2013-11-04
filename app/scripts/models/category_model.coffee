attr = DS.attr

Openedui.Category = DS.Model.extend
  title: attr('string')
  count: attr('number')
  format_count: ( -> @get('count')?.toLocaleString() ).property('count')
