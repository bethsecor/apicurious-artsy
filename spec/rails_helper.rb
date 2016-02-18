# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'vcr'
require 'database_cleaner'
require 'capybara/rails'
require 'capybara/rspec'
require "simplecov"

SimpleCov.start "rails"

ActiveRecord::Migration.maintain_test_schema!

VCR.configure do |c|
  c.cassette_library_dir = "spec/vcr"
  c.hook_into :webmock
end

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:instagram] = OmniAuth::AuthHash.new({
  :provider => 'instagram',
  :uid => '123545',
  :info => {
              :name => 'Miss Capybara',
              :nickname => 'miss.capybara',
              :email => 'capybara@capybara.com',
              :image_url => "https://pbs.twimg.com/profile_images/655716270898311168/tG12v_yG.jpg",
              :bio => "I love testing APIs",
              :website => "http://turing.io"
            },
  :credentials => { :token => ENV['IG_TOKEN'] }
})

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include Capybara::DSL

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

end
