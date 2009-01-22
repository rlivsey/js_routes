# Include hook code here
require 'dispatcher'
require 'js_routes'

Dispatcher.to_prepare :js_routes_route do
  ActionController::Routing::Routes.add_route '/javascripts/js_routes.js', :controller => 'js_routes', :action => 'index'
end