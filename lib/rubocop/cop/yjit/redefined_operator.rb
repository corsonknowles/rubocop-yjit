# frozen_string_literal: true

module RuboCop
  module Cop
    module Yjit
      # TODO: Write cop description and example of bad / good code. For every
      # `SupportedStyle` and unique configuration, there needs to be examples.
      # Examples must have valid Ruby syntax. Do not use upticks.
      #
      # @safety
      #   Delete this section if the cop is not unsafe (`Safe: false` or
      #   `SafeAutoCorrect: false`), or use it to explain how the cop is
      #   unsafe.
      #
      # @example EnforcedStyle: bar (default)
      #   # Description of the `bar` style.
      #
      #   # bad
      #   bad_bar_method
      #
      #   # bad
      #   bad_bar_method(args)
      #
      #   # good
      #   good_bar_method
      #
      #   # good
      #   good_bar_method(args)
      #
      # @example EnforcedStyle: foo
      #   # Description of the `foo` style.
      #
      #   # bad
      #   bad_foo_method
      #
      #   # bad
      #   bad_foo_method(args)
      #
      #   # good
      #   good_foo_method
      #
      #   # good
      #   good_foo_method(args)
      class RedefinedOperator < Base
        MSG = "Avoid redefining basic integer operations such as `+`, `-`, `<`, `>`, etc." \
          " It degrades performance on YJIT."

        BASIC_OPERATIONS = Set.new(%i[+ - < > <= >= * / % **]).freeze

        def on_def(node)
          return unless BASIC_OPERATIONS.include?(node.method_name)

          add_offense(node)
        end
      end
    end
  end
end
