attr = DS.attr("string")

Openedui.HelpVideo = DS.Model.extend
  title: attr
  thumb: attr
  description: attr
  resource_id: attr
  isHelpVideo: ( ->
    true
  ).property()
  embed_url: (->
    "//www.youtube.com/embed/#{@get('resource_id')}?autoplay=1"
  ).property()


Openedui.HelpVideo.FIXTURES = [
  {
    id: 1
    title: "How to Find Resources by Directory or Keyword"
    resource_id: "Ga99hMi7wfY"
  }
  {
    id: 2
    title: "How to Find Resources by Standard"
    resource_id: "ENnAnA8rFnU"
  }
]