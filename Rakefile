require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |task|
  task.libs = ["lib"]
  task.warning = false
  task.verbose = false
  task.test_files = FileList['spec/*_spec.rb']
end

desc "Run all the examples under the spec directory"
task spec: :test

task default: :spec