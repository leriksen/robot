# this MUST come first
# we turn on coverage testing
require 'simplecov'

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.order = :random
  Kernel.srand config.seed

  config.warnings = false

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end
end

# load all classes under lib/**
require 'rake'
Rake::FileList.new("lib/**/*.rb") do |list|
  list.exclude(/tasks/)
end.pathmap("%{^lib/,}X").each {|f| require f}
