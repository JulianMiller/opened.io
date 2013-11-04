Openedui.ShareActionsMixin = Ember.Mixin.create

  fbook_url: ( ->
    'http://www.facebook.com/sharer.php?s=100' +
    '&p[title]=' + encodeURIComponent(@get('title')) +
    (if @get('description') then '&p[summary]=' + encodeURIComponent(@get('description')) else "" ) +
    '&p[url]=' + encodeURIComponent(@get('share_href')) +
    (if @get('thumb') then '&p[image]=' + encodeURIComponent(@get('thumb')) else "")
  ).property('share_href')

  tweet_url: ( ->
    'https://twitter.com/intent/tweet?' +
    'text=' + encodeURIComponent('Check out this ' + @get('share_subject') + ' on OpenEd: ' + @get('share_href'))
  ).property('share_href')

  mailto_url: ( ->
    'mailto:?subject=Check this out on OpenEd!&body=' +
    'Check out this ' + @get('share_subject') + ' on OpenEd: %0D%0A%0D%0A' + @get('share_href')
  ).property('share_href')

