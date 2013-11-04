// This fixes problems with tap events in iPad https://github.com/emberjs/ember.js/issues/605

(function($){
    var touch = {
        start: false, // has the touchstart event been triggered and is it still a valid click event?
        // starting coordinates of touch event
        x: null,
        y: null
    };

    Ember.EventDispatcher.reopen({
        setupHandler: function(rootElement, event, eventName) {
            var self = this;

            rootElement.delegate('.ember-view', event + '.ember', function(evt, triggeringManager) {
                // Track touch events to see how far the user's finger has moved
                // If it is > 20 it will not trigger a click event
                switch(evt.type) {
                    // Remember our starting point
                    case 'touchstart':
                        touch.start = true;
                        touch.x = evt.originalEvent.touches[0].clientX;
                        touch.y = evt.originalEvent.touches[0].clientY;
                        break;

                    // Monitor touchmove in case the user moves their finger away and then back to the original starting point
                    case 'touchmove':
                        if (touch.start) {
                            var moved = Math.max(Math.abs(evt.originalEvent.touches[0].clientX - touch.x),
                                Math.abs(evt.originalEvent.touches[0].clientY - touch.y));
                            if (moved > 20)
                                touch.start = false;
                        }
                        break;

                    // Check end point
                    case 'touchend':
                        if (touch.start) {
                            var moved = Math.max(Math.abs(evt.originalEvent.changedTouches[0].clientX - touch.x),
                                Math.abs(evt.originalEvent.changedTouches[0].clientY - touch.y));
                            if (moved < 20) {
                                // Prevent touchend event so the simulated click event is not triggered
                                evt.preventDefault();
                                // All tests have passed, trigger click event
                                $(evt.target).click();
                            }
                            touch.start = false;
                        }
                        break;
                }

                // END touch code

                var view = Ember.View.views[this.id],
                    result = true, manager = null;

                manager = self._findNearestEventManager(view,eventName);

                if (manager && manager !== triggeringManager) {
                    result = self._dispatchEvent(manager, evt, eventName, view);
                } else if (view) {
                    result = self._bubbleEvent(view,evt,eventName);
                } else {
                    evt.stopPropagation();
                }

                return result;
            });

            rootElement.delegate('[data-ember-action]', event + '.ember', function(evt) {
                var actionId = Ember.$(evt.currentTarget).attr('data-ember-action'),
                    action = Ember.Handlebars.ActionHelper.registeredActions[actionId];
                
                if(typeof action !== 'undefined') {
                  var handler = action.handler;

                  if (action.eventName === eventName) {
                      return handler(evt);
                  }
                }
            });
        }
    });

})(jQuery);

