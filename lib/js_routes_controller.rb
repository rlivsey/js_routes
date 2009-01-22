class JsRoutesController < ActionController::Base

  session :off

  self.template_root = File.join(RAILS_ROOT, 'vendor/plugins/js_routes/views')

  def index
  end

end