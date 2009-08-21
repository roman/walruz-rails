class WalruzPolicyGenerator < Rails::Generator::NamedBase
  default_options :test => 'rspec'
  
  def manifest
    record do |m|
      m.class_collisions "#{class_name}Policy"
      m.directory 'lib/walruz/policies'
      m.template 'policy.rb', File.join('lib/walruz/policies', class_path, "#{file_name}.rb")
    
    
      case options[:test]
      when 'rspec'
        # we generate the rSpec stub
        m.directory 'spec'
        m.directory 'spec/policies'
        m.template 'policy_spec.rb', File.join("spec/policies", "#{file_name}_spec.rb")
      when 'testunit'
        m.directory 'test'
        m.directory 'test/policies'
        m.template 'policy_test.rb', File.join("test/policies", "#{file_name}_test.rb")
      end
    end
  end
  
  protected
  
  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on('--spec', 'Add a rSpec file to the spec folder') { options[:test] = 'rspec' }
    opt.on('--test', 'Add a Test::Unit file to the test folder') { options[:test] = 'testunit' }
  end  
  
  def banner
    "Usage: #{$0} walruz_policy [--spec|--test]"
  end
end
