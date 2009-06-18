$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

begin
  require 'rubygems'
  require 'action_controller'
  require 'action_controller/test_process'
  require 'active_record'
  require 'initializer'
  require 'spec'
  require 'walruz'

  RAILS_ROOT = File.dirname(__FILE__) + '/../tmp'
  module Rails
    
    def self.configuration
      Rails::Configuration.new
    end
  end

  require 'walruz_rails'
  require 'scenario'

  Spec::Runner.configure do |config|
    config.include(ActionController::TestProcess)
  end
  
end

