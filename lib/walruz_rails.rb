require 'rubygems'
require 'walruz'
require 'active_support'
require File.dirname(__FILE__) + '/walruz/controller_mixin'

if defined?(Rails)
  Rails.configuration.after_initialize do
    ActionController::Base.class_eval { include Walruz::ControllerMixin }
  end
end