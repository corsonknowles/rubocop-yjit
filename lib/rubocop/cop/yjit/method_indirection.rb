# frozen_string_literal: true

module RuboCop
  module Cop
    module Yjit
      # Checks for trivial methods that call another method directly.
      # They add unnecessary indirection and reduce performance on YJIT.
      #
      # @safety
      #   Trivial methods are sometimes used to "hoist" a private or protected method call into a public interface.
      #   Such cases would require more refactoring than simple find and replace can provide.
      #
      # @example EnforcedStyle: bar (default)
      #   # Description of the `bar` style.
      #
      #   # bad
      #   def some_method
      #     another_method
      #   end
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
        MSG = "Avoid trivial methods that call another method directly. " \
          "They add unnecessary indirection and reduce performance on YJIT."

        def on_def(node)
          # Check if the body of the method is a single send node (a method call)
          return unless node.body&.send_type?
          return unless trivial_method?(node.body.receiver)

          add_offense(node)
        end

        private

        def trivial_method?(receiver)
          return true if receiver.nil?

          receiver.self_type?
        end
      end
    end
  end
end
