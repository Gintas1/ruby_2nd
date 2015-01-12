require 'simplecov'
require 'database_cleaner'


SimpleCov.start
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true

  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.mock_framework = :mocha

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
