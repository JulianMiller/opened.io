Openedui.StarRatingComponent = Ember.Component.extend
  value: 0
  max: 5
  # see elements.css - rtl direction
  defaultStars: [
    {value: 5, isOn: false}
    {value: 4, isOn: false}
    {value: 3, isOn: false}
    {value: 2, isOn: false}
    {value: 1, isOn: false}
  ]
  autoHide: false
  readOnly: true

  stars: (->
    strs = Em.A([])
    val = @get 'value'
    return @get('defaultStars') if val is null or 0
    for i in [1..@get('max')]
      if i <= val
        strs.pushObject({isOn: true})
      else
        strs.pushObject({isOn: false})
    strs    
  ).property('value')

  actions:
    submit: (star) ->
      if star.value
        self = @
        old = @get 'value'
        self.set 'value', star.value
        data = JSON.stringify
          id: self.get('resourceId')
          rating: star.value
        Em.$.ajax
          type: 'POST'
          url: Openedui.API.url.rating()
          data: data
          contentType: 'application/json'
          dataType: 'json'
          success: (response) =>
          error: (response) =>
            self.set 'value', old
