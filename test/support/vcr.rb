VCR.configure do |config|
  # Filter sensitive information
  config.filter_sensitive_data('api_key') { 'Hello' }

  config.allow_http_connections_when_no_cassette = false
  config.cassette_library_dir = File.expand_path("../../vcr_cassettes", __FILE__)
  config.hook_into :webmock
  config.ignore_request { ENV['DISABLE_VCR'] }
  config.ignore_localhost = true
  config.default_cassette_options = {
    record: :new_episodes
  }
end

