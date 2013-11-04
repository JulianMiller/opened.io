Openedui.GaHelper = Ember.Object.extend()
Openedui.GaHelper.reopenClass
  conversions:
    search:
      id: 990093697
      label: 'DiYxCK_b0gUQgcOO2AM'

  trackConversion: (name) ->
    conv = @conversions[name]
    if conv
      image = new Image(1,1)
      image.src = '//www.googleadservices.com/pagead/conversion/' +
        "#{conv.id}/?label=#{conv.label}&value=1&guid=ON&script=0"
