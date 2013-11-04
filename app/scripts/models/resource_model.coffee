attr = DS.attr

Openedui.Resource = DS.Model.extend Openedui.ShareActionsMixin,
  title: attr('string')
  thumb: attr('string')
  description: attr('string')
  safe_url: attr('string')
  embeddable: attr('boolean')
  contribution_name: attr('string')
  standard_idents: attr('array')
  resource_type: attr('string')
  grades_range: attr('array')
  grade_idents: attr('array')
  rating: attr('number')
  my_rating: attr('number')
  url: attr('string')
  topics: DS.hasMany('Openedui.Topic')

  embed_url: ( ->
    @get('safe_url')
    .replace(/&.*/,"")
    .replace(/watch\?v=/,"embed/") + "?rel=0&autoplay=1"
  ).property('safe_url')

  share_href: ( -> "#{window.location.protocol}//#{window.location.host}/#/share/#{@get('id')}" ).property()
  # ShareActionsMixin properties
  share_subject: ( -> "video" ).property()

Openedui.Resource.reopenClass
  resource_types: [
    {name: 'Videos', value: 'video'}
    {name: 'Games', value: 'game'}
    {name: 'Other', value: 'other'}
  ]

Openedui.Recommend = Openedui.Resource.extend()

Openedui.Store.registerAdapter 'Openedui.Recommend', DS.RESTAdapter.extend
  url: Openedui.API.host + Openedui.API.url.recommended
  buildURL: ()->
    return @url


