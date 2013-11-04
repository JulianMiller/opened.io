###

  This component supports standards identifiers navigation and popover action

  usage:
  {{standards-popover idents=standard_idents title="Standards:"}}

  @param standard_idents {Array}
  @param title {String}

###

Openedui.StandardsPopoverComponent = Ember.Component.extend
  $activePopover: $()

  click: (event) ->
    $link = Em.$ event.target
    unless $link.is('.activate-popover') then return false

    ident = $link.data('standard')

    event.preventDefault()
    $activePopover = @get('$activePopover')

    # if we already opened a popover this the group, destroy it
    if $activePopover[0]
      $activePopover.popover('destroy')
      @set('$activePopover',  $())

    # if we are clicking the same link ignore the rest
    unless $link[0] is $activePopover[0]
      Openedui.Standard.search ident, (standard) =>
        @set '$activePopover', Em.$($link).popover(
          title: "Standard: #{standard.identifier}"
          content: standard.title
          placement: 'top'
          animation: false
        ).popover('show')

    return false

