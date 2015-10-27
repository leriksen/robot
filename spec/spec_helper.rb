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
