Openedui.rootElement = "#ember-testing";
Openedui.setupForTesting();

###

  Custom test helpers

###
Em.Test.registerHelper "select", (app, selector, context) ->
  $el = findWithAssert(selector, context);

  Em.run =>
    $el.attr("selected","selected").parent().focus().change();
    return wait();

exists = (selector) ->
	return !!find(selector).length;

missing = (selector) ->
	error = "element " + selector + " found (should be missing)"
	throws find(selector), error

stubEndpointForHttpRequest = (url, json, method) ->
	method = "GET" || method;

	$.mockjax
		url: url,
		dataType: "json",
		responseText: json,
    contentType:  'application/x-www-form-urlencoded; charset=UTF-8',
		proxyType: method

$.mockjaxSettings.logging = false;
$.mockjaxSettings.responseTime = 0;

Openedui.Router.reopen
  location: "none"


Openedui.Store = DS.Store.extend
  revision: 13
  adapter: DS.FixtureAdapter

###

  Basic FixtureAdapter query method (must be implemented)

###
DS.FixtureAdapter.reopen
  queryFixtures: (fixtures, query, type) ->
    fixtures.filter (item) -> true


Openedui.injectTestHelpers();




