Openedui.PlaylistController = Ember.ObjectController.extend
  itemController: 'resources_show'

  isEditing: false

  actions:
    edit: (playlist) ->
      @set('isEditing', true)

    delete: (playlist) ->
      if window.confirm "Do you want to delete #{playlist.get("name")}?"
        playlist.deleteRecord()
        @get("store").commit()
        @transitionToRoute "playlists"

    update: (playlist)->
      @get('store').commit()
      @set 'isEditing', false

    removeFromPlaylist: (resource_id) ->
      playlistResources = Openedui.PlaylistResource.find
                                              resource_id: resource_id,
                                              playlist_id: @get('content.id')
      playlistResources.one 'didLoad', =>
        playlistResources.get('firstObject').deleteRecord()
        @get('store').commit()