Openedui.TopicPlaylistResourcesController = Ember.ArrayController.extend
  itemController: 'topicResource'

  selectedPlaylist: null

  selectedPlaylistChanged: (->
    @set 'content', @get("selectedPlaylist.resources")
  ).observes('selectedPlaylist')
