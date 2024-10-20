# frozen_string_literal: true

require "rubocop/yjit/version"
require "yaml"

module RuboCop
  # An extension of RuboCop focused on exploratory YJIT optimizations
  module Yjit
    class Error < StandardError; end

    PROJECT_ROOT   = Pathname.new(__dir__).parent.parent.expand_path.freeze
    CONFIG_DEFAULT = PROJECT_ROOT.join("config", "default.yml").freeze
    CONFIG         = YAML.safe_load(CONFIG_DEFAULT.read).freeze

    private_constant(:CONFIG_DEFAULT, :PROJECT_ROOT)

    ::RuboCop::ConfigObsoletion.files << PROJECT_ROOT.join("config", "obsoletion.yml")
  end
end
