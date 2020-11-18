Datadog.configure do |c|
  # This will activate auto-instrumentation for Rails
  c.use :rails
  c.use :active_model_serializers, {analytics_enabled: true}
  c.use :faraday, {analytics_enabled: true}
end
