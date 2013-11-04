Openedui.ResourcesShowController = Ember.ObjectController.extend

  needs: "application"

  isSignedIn: Ember.computed.alias("controllers.application.isSignedIn")

  displayAddToPlaylistButton: (->
    @get("target") instanceof Openedui.SearchController
  ).property()

  displayRemoveFromPlaylistButton: (->
    @get("target") instanceof Openedui.PlaylistController
  ).property()
