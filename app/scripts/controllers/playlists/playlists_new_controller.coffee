Openedui.PlaylistsNewController = Ember.ArrayController.extend

  actions:
    create: ->
      self = @
      playlist = Openedui.Playlist.createRecord name: @get('name')
      @set 'name', ''
      playlist.on 'didCreate', ->
        Ember.run.next self, ->
          self.transitionToRoute('playlist', playlist)
      @get('store').commit()