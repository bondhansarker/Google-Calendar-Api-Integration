ENV['RAILS_ENV'] ||= 'test'
require_relative("../config/environment" )
require "minitest/autorun"
require "capybara/rails"
include Rails.application.routes.url_helpers
DatabaseCleaner.clean_with :truncation
DatabaseCleaner.strategy = :transaction

class Minitest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end