# frozen_string_literal: true
require File.expand_path("../../config/environment", __FILE__)
require 'rails/all'
require 'rspec/rails'


RSpec.configure do |config|

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view

  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It mak
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

end

