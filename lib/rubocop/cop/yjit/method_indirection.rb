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
      class MethodIndirection < Base
        MSG = "Avoid trivial methods that call another method directly." \
          " They add unnecessary indirection and reduce performance on YJIT."

        def on_def(node)
          # Check if the body of the method is a single send node (a method call)
          return unless node.body&.send_type?
          return unless trivial_method?(node.body)

          add_offense(node)
        end

        private

        def trivial_method?(body)
          # A method call with no receiver (i.e., another_method) or with `self` as the receiver
          receiver = body.receiver
          receiver.nil? || receiver.self_type?
        end
      end
    end
  end
end
