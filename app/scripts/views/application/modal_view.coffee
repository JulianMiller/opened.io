Openedui.ModalView = Ember.View.extend
  didInsertElement: ->
    Ember.$.fancybox.open(@$(),
      helpers : {
        title : {
          type : 'inside'
        },
        overlay : {
          css : {
            'background' : 'rgba(238, 238, 238, 0.85)'
          }
        }
      },
      modal: true,
      closeBtn: false,
      maxWidth: @get('width'),
      minWidth: @get('width'),
      topRatio: 0.2
    )


  willDestroyElement: ->
    Ember.$.fancybox.close()