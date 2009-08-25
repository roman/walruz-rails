class WalruzGenerator < Rails::Generator::Base
  
  def manifest
    record do |m|
      m.file('walruz_initializer.rb', 'config/initializers/walruz_initializer.rb')
      
      m.directory 'lib/walruz'
      m.directory 'lib/walruz/policies'
      m.file('policies.rb', 'lib/walruz/policies.rb')
      m.file('actor_is_subject_example.rb', 'lib/walruz/policies/actor_is_subject.rb')
      
      task_template_name = if File.exists?(File.join(Rails.root, "spec"))
        'spec_task.rake'
      else
        'test_task.rake'
      end
      m.file(task_template_name, 'lib/tasks/walruz.rake')

      m.file('unauthorized.html', 'public/unauthorized.html')
    end
  end
  
  def banner
    "Usage: #{$0} walruz"
  end
  
end
