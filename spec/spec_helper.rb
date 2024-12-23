# frozen_string_literal: true

require "simplecov"
SimpleCov.start

require "rubocop-yjit"
require "rubocop/rspec/support"
require "debug/prelude"

RSpec.configure do |config|
  config.include(RuboCop::RSpec::ExpectOffense)

  config.disable_monkey_patching!
  config.raise_errors_for_deprecations!
  config.raise_on_warning = true
  config.fail_if_no_examples = true

  config.order = :random
  Kernel.srand(config.seed)
end
