###

  Share Actions test

###

module 'Share Actions',
  setup: ->
    Em.run ->
      Openedui.reset()
      Openedui.deferReadiness()

test 'Resource url sharing', ->
  expect(11)
  Em.run ->
    Openedui.advanceReadiness()

    resource = Openedui.Resource.createRecord title: 'Res1', description: "Descr1", thumb: 'Thumb1'

    notEqual resource.get('fbook_url').indexOf(resource.get('title')), -1, "Expected facebook title"
    notEqual resource.get('fbook_url').indexOf('www.facebook.com'), -1, "Expected facebook url"
    notEqual resource.get('fbook_url').indexOf(resource.get('description')), -1, "Expected facebook description"
    notEqual resource.get('fbook_url').indexOf(resource.get('thumb')), -1, "Expected facebook thumb"
    notEqual resource.get('fbook_url').indexOf(resource.get('id')), -1, "Expected facebook url with id"

    notEqual resource.get('tweet_url').indexOf(resource.get('id')), -1, "Expected twitter url with id"
    notEqual resource.get('tweet_url').indexOf('twitter.com'), -1, "Expected twitter url"
    notEqual resource.get('tweet_url').indexOf('video'), -1, "Expected twitter welcome message"

    notEqual resource.get('mailto_url').indexOf(resource.get('id')), -1, "Expected mailto url with id"
    notEqual resource.get('mailto_url').indexOf('mailto'), -1, "Expected mailto url"
    notEqual resource.get('mailto_url').indexOf('video'), -1, "Expected mailto welcome message"

test 'Playlist url sharing', ->
  expect(9)
  Em.run ->
    Openedui.advanceReadiness()

    playlist = Openedui.Playlist.createRecord name: 'List1', slug: "List1Slug"

    notEqual playlist.get('fbook_url').indexOf(playlist.get('name')), -1, "Expected facebook title"
    notEqual playlist.get('fbook_url').indexOf('www.facebook.com'), -1, "Expected facebook url"
    notEqual playlist.get('fbook_url').indexOf(playlist.get('slug')), -1, "Expected facebook url with id"

    notEqual playlist.get('tweet_url').indexOf(playlist.get('slug')), -1, "Expected twitter url with id"
    notEqual playlist.get('tweet_url').indexOf('twitter.com'), -1, "Expected twitter url"
    notEqual playlist.get('tweet_url').indexOf('playlist'), -1, "Expected twitter welcome message"

    notEqual playlist.get('mailto_url').indexOf(playlist.get('slug')), -1, "Expected mailto url with id"
    notEqual playlist.get('mailto_url').indexOf('mailto'), -1, "Expected mailto url"
    notEqual playlist.get('mailto_url').indexOf('playlist'), -1, "Expected mailto welcome message"