Walruz.setup do |config|
  
  # All the models of ActiveRecord can behave as actors and subjects
  config.actors   = [ActiveRecord::Base]
  config.subjects = [ActiveRecord::Base]
  
  ActionController::Base.class_eval do
    
    rescue_from Walruz::NotAuthorized, :with => :unauthorized
    
    #
    # This method will be called when a user is not authorized. By
    # default it renders an unauthorized template on the public directory
    # with a HTTP status 401 (not authorized)
    # This method can be overwritted in childs of ActionController::Base
    # to have a better handling of unauthorized exceptions
    def unauthorized(e)
      render :file => "#{RAILS_ROOT}/public/unauthorized.html", :status => 401
    end
    
  end
end