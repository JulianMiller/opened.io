Openedui.PlaylistsModalController = Ember.ArrayController.extend

  addToPlaylist: (playlist) ->
    playlist.get('resource_ids').pushObject(parseInt(@get('resource.id')))

    playlistResource = Openedui.PlaylistResource.createRecord
      playlist_id: playlist.get('id')
      resource: @get('resource')
    @set 'message', "Added to #{playlist.get('name')}"
    playlistResource.save()

  actions:
    createPlaylist: ->
      if @get('name')
        playlist = Openedui.Playlist.createRecord name: @get('name')
        playlist.save().then =>
          # When we create playlist, resource should be added to it
          Ember.run.next =>
            @addToPlaylist playlist
            @set 'name', ''

Openedui.PlaylistsItemController = Ember.ObjectController.extend

  isInPlaylist: ( ->
    resource_ids = @get('resource_ids') || []
    resource_ids.indexOf(parseInt(@get('target.resource.id'))) > -1
  ).property('resource_ids.@each')

  resourcesCount: ( ->
    resource_ids = @get('resource_ids') || []
    resource_ids.length
  ).property('resource_ids.@each')

  actions:
    add: (playlist) ->
      @get('target').addToPlaylist playlist
