namespace :js_routes do
  
  desc "Caches routes.js so that it's not dynamically generated on each request"
  task :cache do
    require File.expand_path(File.dirname(__FILE__) + "/../../../../config/environment")  
    require 'js_routes'
 
    File.open("#{RAILS_ROOT}/public/javascripts/js_routes.js", "w") do |out|
      out << CitySafe::Plugins::JsRoutes::display_js_routes
    end    
    
  end

end