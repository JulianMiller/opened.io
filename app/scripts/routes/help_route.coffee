Openedui.HelpRoute = Ember.Route.extend
  model: ->
    Openedui.HelpVideo.find()

  actions:
    openModal: (model) ->
      ctrl= @controllerFor('help')
      ctrl.set "currentModel", model

      @render 'help/modal',
        into: 'help'
        outlet: 'modal'

    closeModal: ->
      ctrl= @controllerFor('help')
      ctrl.set "currentModel", null

      @render 'nothing',
        into: 'help'
        outlet: 'modal'