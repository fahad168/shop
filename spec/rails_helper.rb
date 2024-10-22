# spec/rails_helper.rb

# Require RSpec and any other necessary testing libraries
# require "rspec/rails"
require "cart_management"

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.

RSpec.configure do |config|
  # If you want to run your tests within a transaction, uncomment this line
  # This will make tests faster by rolling back changes after each test
  # config.use_transactional_fixtures = true

  # Add additional requires or configurations here
  # e.g., if you are using FactoryBot for factories
  config.include FactoryBot::Syntax::Methods

  # Configure how your tests are run
  config.fixture_path = "#{::Rails.root}/spec/fixtures"  # Path for fixture files
  config.infer_spec_type_from_file_location!  # Automatically set test types based on file location
  config.filter_rails_from_backtrace!  # Filter out Rails gems from backtrace
end
