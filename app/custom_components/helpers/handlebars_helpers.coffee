###

  If Equals
  if_eq this compare=that

###

Ember.Handlebars.registerBoundHelper 'if_eq',  (context, options) ->
  if context == options.hash.compare
    return options.fn(this)
  else
    return options.inverse(this)


###

  Truncate string by len parameter
  usage
  {{ truncate item.description len=65 }}
###

Ember.Handlebars.registerBoundHelper 'truncate', (obj, options) ->
  len = options.hash.len
  str = obj

  if (str && str.length > len)
    new_str = str.substr( 0, len + 1 );

    while ( new_str.length )
      ch = new_str.substr( -1 );
      new_str = new_str.substr( 0, -1 );

      if ( ch == ' ' )
        break;

    if ( new_str == '' )
      new_str = str.substr( 0, len )

    return new Handlebars.SafeString( new_str + '...' )
  return str

###

  format an ISO date using Moment.js
  http://momentjs.com/
  moment syntax example: moment(Date("2011-07-18T15:50:52")).format("MMMM YYYY")
  usage: {{dateFormat creation_date format="MMMM YYYY"}}

###

Ember.Handlebars.registerBoundHelper 'dateFormat', (context, block) ->
  if (window.moment && context && moment(context).isValid())
    f = block.hash.format || "MMM Do, YYYY"
    return moment(Date(context)).format(f)
  else
    return context;

###

  For each helper
  {{#foreach foo}}
    <div class='{{#if $first}} first{{/if}}{{#if $last}} last{{/if}}'></div>
  {{/foreach}}
###

Ember.Handlebars.registerBoundHelper "foreach", (arr, options) ->
  if(options.inverse && !arr.length)
    return options.inverse(this);

    return arr.map((item,index) ->
      item.$index = index;
      item.$first = index == 0;
      item.$last  = index == arr.length-1;
      return options.fn(item);
    ).join('')
