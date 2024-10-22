# frozen_string_literal: true

module RuboCop
  module Cop
    module Yjit
      # Checks for methods that only return a constant or hash value.
      # These methods add unnecessary method call overhead and can be replaced
      # with direct constant or hash access.
      #
      # @example
      #   # bad
      #   def answer
      #     42
      #   end
      #
      #   # bad
      #   def pi
      #     3.14159
      #   end
      #
      #   # bad
      #   def get_hash
      #     { key: 'value' }
      #   end
      #
      #   # good
      #   ANSWER = 42
      #
      #   # good
      #   PI = 3.14159
      #
      #   # good
      #   HASH = { key: 'value' }
      #
      #   # good
      #   def complex_calculation
      #     # Some non-trivial logic here
      #     result
      #   end
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
