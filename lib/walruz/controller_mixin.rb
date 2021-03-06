module Walruz
  module ControllerMixin
    
    def self.included(base)
      base.class_eval do
        include InstanceMethods
        extend ClassMethods
        helper_method(:policy_params)
      end
    end
    
    module InstanceMethods
      
      def set_policy_params!(params)
        @_policy_params = params
      end
      
      def policy_params
        @_policy_params
      end
      
    end
    
    module ClassMethods
      
      #
      # Returns a before filter that will check if the actor returned by the method `current_user` can execute the 
      # given action on the given subject.
      # 
      # Requirements:
      #   - The controller must have a method called `current_user` that returns the authenticated user
      #
      # Parameters:
      #   - action:  Symbol that represents the action wich will be executed on the subject
      #   - subject: Symbol that indicates an instance variable or method on the controller that
      #              returns the subject
      #
      # Returns:
      #   A proc that will be executed as a before_filter method
      #
      # Example:
      #
      #   class UserController < ActionController::Base
      #     
      #     before_filter check_authorization!(:create, :user), :only => [:new, :create]
      #     before_filter check_authorization!(:destroy, :complicated_method_that_returns_a_user), :only => :destroy
      #
      #     def complicated_method_that_returns_a_user
      #       # some complex logic here
      #       return user
      #     end
      #   end
      #
      def check_authorization!(action, subject)
        lambda do |controller|
          # we get the subject
          subject_instance = if controller.instance_variable_defined?("@%s" % subject)
                      controller.instance_variable_get("@%s" % subject)
                    elsif controller.respond_to?(subject)
                      controller.send(subject)
                    else
                      error_message = "There is neither an instance variable @%s nor a instance method %s on the %s instance context" % [subject, subject, controller.class.name]
                      raise ArgumentError.new(error_message)
                    end
          params = Walruz.authorize!(controller.send(:current_user), action, subject_instance)
          controller.set_policy_params!(params)
        end
      end

      # TODO: Documentation
      def check_policy!(policy_label, subject = nil)
        lambda do |controller|
          subject_instance = nil
          if subject
            subject_instance = if controller.instance_variable_defined?("@%s" % subject)
              controller.instance_variable_get("@%s" % subject)
            elsif controller.respond_to?(:"#{subject}")
              controller.send(:"#{subject}")
            end
          end
          params = Walruz.satisfies!(controller.send(:current_user), policy_label, subject_instance)
          controller.set_policy_params!(params)
        end
      end
      
      
      #
      # Generates dynamically all the before filters needed for authorizations on a CRUD model.
      # 
      # Requirements:
      #  - The controller must have a method called `current_user` that returns the authenticated user
      #  - The subject must implement the four actions (:create, :read, :update, :destroy) or have a :default action
      #  
      # Parameters:
      #   - subject: Symbol that indicates an instance variable or method on the controller that
      #              returns the subject
      #
      # Example:
      #
      #   class CommentController < ActionController::Base
      #     
      #     before_check_crud_authorizations_on :@comment
      #
      #     # This would be the same as:
      #     # before_filter check_authorization!(:create, :@comment),  :only => [:new, :create]
      #     # before_filter check_authorization!(:read, :@comment),    :only => :show
      #     # before_filter check_authorization!(:update, :@comment),  :only => [:edit, :update]
      #     # before_filter check_authorization!(:destroy, :@comment), :only => :destroy
      #   
      #   end
      #
      def before_check_crud_authorizations_on(subject)
        [
          [:create, ['new', 'create']],
          [:read, 'show'],
          [:update, ['edit', 'update']],
          [:destroy, 'destroy']
        ].each do |(actor_action, actions)|
          before_filter(check_authorization!(actor_action, subject), :only => actions)
        end
      end
      
    end
    
  end
end
