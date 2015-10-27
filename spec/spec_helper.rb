RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.order = :random
  Kernel.srand config.seed

  config.warnings = false

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end
end

# load all classes under lib/**
require 'rake'
Rake::FileList.new("lib/**/*.rb") do |list|
  list.exclude(/tasks/)
end.pathmap("%{^lib/,}X").each {|f| require f}
