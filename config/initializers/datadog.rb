require 'rspec'
require 'ddtrace'

Datadog.configure do |c|
  # This will activate auto-instrumentation for Rails
  c.use :rails
  # Configure default RSpec integration
  c.use :rspec, options
end
