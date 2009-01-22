JsRoutes
========

Note this is a fairly old plugin, [js_named_routes](http://github.com/jsierles/js_named_routes/tree/master) is a more up to date and fully featured take on the same problem.

Include '/javascripts/js_routes.js' in your HTML and it makes your routes available in javascript.

    <%= javascript_include_tag :js_routes %>

In rails:

    message_url(@message, :format => 'js')

Javascript:

    var message_id = 1;
    message_url(message_id, {format: 'js'})

These are built on the fly, to cache them for production run the task:
    $rake js_routes:cache