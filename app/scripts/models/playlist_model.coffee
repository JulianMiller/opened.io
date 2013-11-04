Openedui.Playlist = DS.Model.extend Openedui.ShareActionsMixin,
  name: DS.attr('string')
  slug: DS.attr('string')
  resource_ids: DS.attr('array')
  playlist_resources: DS.hasMany('Openedui.PlaylistResource')

  resources: (->
    @get("resource_ids").map (resource_id)->
      Openedui.Resource.find(resource_id)
  ).property('resource_ids')

  link: (->
    "#{window.location.protocol}//#{window.location.host}/#/shared-playlist/#{@get("slug")}"
  ).property("slug")

  # ShareActionsMixin properties
  share_href: ( -> @get("link") ).property("link")
  title: ( -> @get("name") ).property("name")
  share_subject: ( -> "playlist" ).property()

Openedui.Store.registerAdapter 'Openedui.Playlist', Openedui.Adapter.extend
  url: "#{Openedui.API.host}/users"
