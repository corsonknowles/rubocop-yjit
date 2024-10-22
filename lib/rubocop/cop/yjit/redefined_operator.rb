# frozen_string_literal: true

module RuboCop
  module Cop
    module Yjit
      # Checks for redefining basic integer operations such as `+`, `-`, `<`, `>`, etc.
      # This degrades performance on YJIT.
      #
      # @safety
      #   Redefining basic integer operations is unsafe and can lead to unexpected behavior.
      #   There is no safe automatic correction for this issue.
      #
      # @example
      #   # bad
      #   def +(other)
      #     # custom addition logic
      #   end
      #
      #   # bad
      #   def -(other)
      #     # custom subtraction logic
      #   end
      #
      #   # bad
      #   def <(other)
      #     # custom less than comparison
      #   end
      #
      #   # good
      #   def custom_addition(other)
      #     # custom addition logic
      #   end
      #
      #   # good
      #   def custom_subtraction(other)
      #     # custom subtraction logic
      #   end
      #
      #   # good
      #   def custom_less_than(other)
      #     # custom less than comparison
      #   end
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
