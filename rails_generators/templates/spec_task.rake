# Generate rSpec tasks
begin
  require "spec/rake/spectask"
rescue MissingSourceFile
  raise <<-MSG
I tried to generate some spec rake tasks for you, but it seems you have some problem with 
your rSpec installation, please check and try again.
  MSG
else
  spec_prereq = File.exist?(File.join(RAILS_ROOT, 'config', 'database.yml')) ? "db:test:prepare" : :walruz_noop
  task :walruz_noop do
  end
  namespace :spec do
    desc "Run all walruz policies specs in spec/policies"
    Spec::Rake::SpecTask.new(:policies => spec_prereq) do |t|
      t.spec_opts  = ['--options', "\"#{RAILS_ROOT}/spec/spec.opts\""]
      t.spec_files = FileList["spec/policies/**/*_spec.rb"]
    end
  end
end

