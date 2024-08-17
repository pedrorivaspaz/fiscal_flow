# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'simplecov'

SimpleCov.start do
  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Jobs', 'app/jobs'
  add_group 'Helpers', 'app/helpers'
  add_group 'Specs', 'spec'
end

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

Rails.root.glob('spec/support/**/*.rb').sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|

  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]

  config.use_transactional_fixtures = true

  config.include Devise::Test::IntegrationHelpers, type: :request
  
  config.include FactoryBot::Syntax::Methods

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
