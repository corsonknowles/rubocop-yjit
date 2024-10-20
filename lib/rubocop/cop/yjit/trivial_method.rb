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
      class TrivialMethod < Base
        MSG = "Avoid methods that only return a constant or hash value. They add unnecessary method call overhead."

        def on_def(node)
          return unless trivial_method?(node.body)

          add_offense(node)
        end

        private

        def trivial_method?(body)
          body.const_type? || (body.send_type? && body.method?(:[]))
        end
      end
    end
  end
end
