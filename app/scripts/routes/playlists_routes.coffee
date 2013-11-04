Openedui.PlaylistsRoute = Openedui.AuthenticatedRoute.extend
  model: ->
    Openedui.Playlist.find()

Openedui.PlaylistRoute = Openedui.AuthenticatedRoute.extend
  model: (params) ->
    Openedui.Playlist.find(params.playlist_id)

  renderTemplate: ->
    @render "playlists/playlist"

Openedui.SharedPlaylistRoute = Ember.Route.extend
  model: (params) ->
    Openedui.SharedPlaylist.find params.slug

  renderTemplate: ->
    @render "playlists/shared"