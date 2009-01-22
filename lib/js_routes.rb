module CitySafe
  module Plugins
    module JsRoutes
    
      def self.display_js_routes
          out = ''
          ::ActionController::Routing::Routes.named_routes.each do |name, route|
            out << display_js_route(name, route)
          end
          
          out << <<-EOD
          
            function route_format(format)
            {
              return format == undefined ? 'js' : format;
            }
            
            function route_params(params)
            {
              if (params == undefined)
                return '';
                
              var out = '?';
            
              $H(params).each(function(kv){
                out += kv[0]+'='+kv[1]+'&';
              });
              
              return out;
            }
          
          EOD
          
              
          out
        end
        
        private
        
        def self.display_js_route(name, route)
          out = "function #{name}_url(#{(dynamic_segment_values(route) + ['params']).join(', ')}){\n"
          out << "  format = route_format(format);\n" if route_includes_format? route
          out << '  return ' + build_js_url_for_route(route) + "\n"
          out << "}\n\n"
        end
      
        def self.build_js_url_for_route(route)
          out = "'"
          route.segments.each do |segment|
            out << if segment.instance_of? ::ActionController::Routing::StaticSegment
                     segment.value
                   elsif segment.instance_of? ::ActionController::Routing::DynamicSegment
                     "'+#{segment.key}+'"
                   elsif segment.instance_of? ::ActionController::Routing::DividerSegment
                     segment.value
                   end    
          end
          
          out << "'+route_params(params);"
        end
      
        def self.route_includes_format?(route)
          route.segments.each do |segment|
            if segment.instance_of? ::ActionController::Routing::DynamicSegment
              return true if segment.key == :format
            end
          end
          false
        end
      
        def self.dynamic_segment_values(route)
          names = []
          route.segments.each do |segment|
            if segment.instance_of? ::ActionController::Routing::DynamicSegment    
              names << segment.key.to_s
            end
          end
          names
        end  
    
    end
  end
end
