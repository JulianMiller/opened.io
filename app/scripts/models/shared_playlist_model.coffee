Openedui.SharedPlaylist = Openedui.Playlist.extend
  name: DS.attr('string')
  slug: DS.attr('string')
  playlist_resources: DS.hasMany('Openedui.PlaylistResource')


DS.RESTAdapter.map 'Openedui.SharedPlaylist',
  playlist_resources:
    embedded: 'load'