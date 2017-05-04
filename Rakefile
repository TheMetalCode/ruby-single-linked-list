begin
  require 'rspec/core/rake_task'

  desc "Run specs"
  RSpec::Core::RakeTask.new do |t|
    t.pattern = '*_spec.rb'
  end
rescue LoadError
  #nothing
end

begin
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new
rescue LoadError
  #nothing
end

task default: [:spec, :rubocop]
task test: :spec
