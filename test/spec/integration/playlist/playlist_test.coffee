###

  Playlist test

###

savedMsg = null

module 'Playlist',
  setup: ->
    Openedui.reset()

test 'playlist index', ->
  expect(3)

  visit('/playlists').then ->
    equal($(".ts-playlists-caption").length, 1, 'Expected Title found')
    equal($(".ts-playlists-newButton").length, 1, 'Expected New button found')
    rows = find('.ts-playlist-list-item').length
    equal(rows, 2, 'Expected 2 playlist but loaded ' + rows)

test 'new playlist test', ->
  expect(5)

  visit('/playlists/new').then ->
    equal($(".ts-playlist-create").length, 1, 'Expected Create found')
    equal($(".ts-playlist-name").length, 1, 'Expected Name found')
    equal($(".ts-playlist-inputName").length, 1, 'Expected Edit found')

    fillIn( ".ts-playlist-inputName", "ListAuto" )

    click(".ts-playlist-create")
  .then ->
    rows = find('.ts-playlist-list-item').length
    equal(rows, 3, 'Expected 3 playlist but loaded ' + rows)
    equal $(".ts-playlist-list-item").eq(2).text(), 'ListAuto'

test 'playlist item', ->
  expect(4)

  visit('/playlists/66947').then ->
    equal($(".top-actions").length, 1, 'Expected Action bar found')
    equal($(".ts-playlist-title").length, 1, 'Expected Name found')
    equal $(".ts-playlist-title").text(), 'Test2'

    rows = find('.resource__list > li').length
    equal(rows, 2, 'Expected 2 resources but loaded ' + rows)

test 'playlist item rename', ->
  expect(6)

  visit('/playlists/66947').then ->
    equal($(".top-actions").length, 1, 'Expected Action bar found')
    equal($(".ts-playlist-rename").length, 1, 'Expected Rename button found')

    equal($(".ts-playlist-title").length, 1, 'Expected Name found')
    equal $(".ts-playlist-title").text(), 'Test2'

    click($(".ts-playlist-rename"))
  .then ->
    fillIn( ".ts-playlist-updateName", "ARenameTest" )
    click($(".ts-playlist-update").eq(0))
  .then ->
    rows = find('.ts-playlist-list-item').length
    equal(rows, 3, 'Expected 3 playlist but loaded ' + rows)
    equal $(".ts-playlist-list-item").eq(1).text(), 'ARenameTest'

test 'playlist item remove', ->
  expect(5)

  visit('/playlists/66947').then ->
    rows = find('.ts-playlist-list-item').length
    equal(rows, 3, 'Expected 3 playlist but loaded ' + rows)

    equal($(".top-actions").length, 1, 'Expected Action bar found')
    equal($(".ts-playlist-delete").length, 1, 'Expected Delete button found')

    window.confirm = (msg) ->
      savedMsg = msg

    click($(".ts-playlist-delete"))
  .then ->
      rows = find('.ts-playlist-list-item').length
      equal(rows, 2, 'Expected 2 playlist but loaded ' + rows)
      notEqual( savedMsg, "", 'Expected confirm message not empty.')
