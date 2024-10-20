# frozen_string_literal: true

# The original code is from https://github.com/rubocop-hq/rubocop-rspec/blob/master/lib/rubocop/rspec/inject.rb
# See https://github.com/rubocop-hq/rubocop-rspec/blob/master/MIT-LICENSE.md
module RuboCop
  module Yjit
    # Because RuboCop doesn't yet support plugins, we have to monkey patch in a
    # bit of our configuration.
    module Inject
      class << self
        def defaults!
          path = CONFIG_DEFAULT.to_s
          hash = ConfigLoader.send(:load_yaml_configuration, path)
          hash["Yjit"] ||= {}
          hash["Yjit"]["DocumentationBaseURL"] = "https://github.com/corsonknowles/rubocop-Yjit/blob/main/manual"
          hash["Yjit"]["DocumentationExtension"] = ".md"
          config = Config.new(hash, path).tap(&:make_excludes_absolute)
          config = ConfigLoader.merge_with_default(config, path)
          ConfigLoader.instance_variable_set(:@default_configuration, config)
        end
      end
    end
  end
end
