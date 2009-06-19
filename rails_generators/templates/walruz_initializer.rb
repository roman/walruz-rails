Walruz.setup do |config|
  
  
  config.actors   = [ActiveRecord::Base]
  config.subjects = [ActiveRecord::Base]
  
  ActionController::Base.class_eval do
    
    rescue_from Walruz::NotAuthorized, :with => :unauthorized
    
    #
    # This method will be called when a user is not authorized. By
    # default it renders a unauthorized template on the public directory
    # with a HTTP status 401 (not authorized)
    def unauthorized(e)
      render :template => 'public/unauthorized.html', :status => 401
    end
    
  end
end