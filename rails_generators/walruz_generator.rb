class WalruzGenerator < Rails::Generator::Base
  
  def manifest
    record do |m|
      m.directory 'config/initializers'
      m.file('walruz_initializer.rb', 'config/initializers/walruz_initializer.rb')
      
      m.directory 'lib/walruz'
      m.directory 'lib/walruz/policies'
      m.file('policies.rb', 'lib/walruz/policies.rb')
      m.file('actor_is_subject_example.rb', 'lib/walruz/policies/actor_is_subject.rb')
      
      m.directory 'public'
      m.file('unauthorized.html', 'public/unauthorized.html')
    end
  end
  
  def banner
    "Usage: #{$0} walruz"
  end
  
end