Openedui.ProfileSignupView = Ember.View.extend

  activeTab: Ember.computed.alias("controller.activeTab")

  activeTabDidChange: (->
    @setActiveTab()  if @state is "inDOM"
  ).observes("activeTab")

  didInsertElement: ->
    @setActiveTab()

  setActiveTab: ->
    $(".active").removeClass "active"
    activeTab = @get("activeTab")
    @$("a[data-tab='%@']".fmt(activeTab)).parent().addClass "active"