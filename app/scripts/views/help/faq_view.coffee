Openedui.HelpFaqView = Ember.View.extend
  templateName: 'help/faq'
  tagName: "dl"
  classNames: ["dl-accordion"]

  didInsertElement: ->
    $("dd").hide()

  click: (event) -> #TODO refactor to ember-way events
    el = $(event.target)
    if el.prop("tagName") is "DT"
      dd = el.next()
      if dd.is(":visible")
        $("dt").removeClass('active')
        $("dd").hide()
      else
        $("dt").removeClass('active')
        $("dd").hide()
        el.addClass('active')
        dd.show()
