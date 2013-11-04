Openedui.PlaylistResource = DS.Model.extend
  resource: DS.belongsTo('Openedui.Resource')
  playlist_id: DS.attr('number')

Openedui.Store.registerAdapter 'Openedui.PlaylistResource', Openedui.Adapter.extend
  url: "#{Openedui.API.host}/users"

Openedui.Adapter.map 'Openedui.PlaylistResource',
  resource:
    embedded: 'load'