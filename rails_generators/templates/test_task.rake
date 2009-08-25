# Generate Test::Unit tasks
require "rake/testtask"
namespace :test do
  Rake::TestTask.new(:policies => "db:test:prepare") do |t|
    t.libs << "test"
    t.pattern = 'test/policies/**/*_test.rb'
    t.verbose = true
  end
  Rake::Task['test:policies'].comment = "Run all walruz policies tests in test/policies"
end
