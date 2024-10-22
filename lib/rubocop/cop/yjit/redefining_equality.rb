# frozen_string_literal: true

module RuboCop
  module Cop
    module Yjit
      # Checks for redefinition of `nil?`, `==`, or `!=` methods.
      # Redefining these methods can negatively impact YJIT performance.
      #
      # @safety
      #   Redefining equality methods can lead to unexpected behavior in other parts of the code.
      #   Correcting this issue may require careful refactoring and testing.
      #
      # @example
      #   # bad
      #   class MyClass
      #     def nil?
      #       # custom implementation
      #     end
      #   end
      #
      #   # bad
      #   class MyClass
      #     def ==(other)
      #       # custom implementation
      #     end
      #   end
      #
      #   # bad
      #   class MyClass
      #     def !=(other)
      #       # custom implementation
      #     end
      #   end
      #
      #   # good
      #   class MyClass
      #     def my_nil_checker?(value)
      #       value.nil?
      #     end
      #   end
      #
      #   # good
      #   class MyClass
      #     def custom_equality(other)
      #       # custom implementation that doesn't override ==, !=, or nil?
      #     end
      #   end
      class RedefiningEquality < Base
        MSG = "Avoid redefining `nil?`, `==`, or `!=`. This can negatively impact YJIT performance."

        EQUALITY_OPERATIONS = Set.new(%i[nil? == !=]).freeze

        def on_def(node)
          return unless EQUALITY_OPERATIONS.include?(node.method_name)

          add_offense(node)
        end
      end
    end
  end
end
