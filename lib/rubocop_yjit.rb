# frozen_string_literal: true

require "rubocop"

require_relative "rubocop/yjit"
require_relative "rubocop/yjit/version"
require_relative "rubocop/yjit/inject"

RuboCop::Yjit::Inject.defaults!

require_relative "rubocop/cop/yjit_cops"
