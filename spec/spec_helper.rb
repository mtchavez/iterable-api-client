require 'simplecov'

if ENV['COVERALLS_REPO_TOKEN']
  require 'coveralls'
  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
end

SimpleCov.at_exit do
  SimpleCov.result.format!
end

SimpleCov.start do
  add_filter '/spec/'
  add_filter 'vendor'
end

project_root = File.expand_path(File.dirname(__FILE__) + '/..')
$LOAD_PATH << "#{project_root}/lib"

require 'rubygems'
require 'iterable-api-client'
require 'vcr'
require 'pry'

require 'dotenv'
Dotenv.load

Dir["#{project_root}/spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  config.warnings = true
  config.profile_examples = 10

  config.before do
    Iterable.configure do |conf|
      conf.token = ENV['ITERABLE_TOKEN']
    end
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end

VCR.configure do |config|
  config.hook_into :webmock, :typhoeus
  config.cassette_library_dir     = 'spec/cassettes'
  config.ignore_localhost         = true
  config.default_cassette_options = { record: :new_episodes }

  config.filter_sensitive_data('<ITERABLE_TOKEN>') { ENV['ITERABLE_TOKEN'] }
  config.configure_rspec_metadata!
end
