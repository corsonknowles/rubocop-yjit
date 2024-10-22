# frozen_string_literal: true

module RuboCop
  module Cop
    module Yjit
      # Checks for changes in variable types within the same scope.
      # YJIT performs better when variables have a consistent type.
      # This applies to both local variables and instance variables.
      #
      # @example
      #   # bad
      #   x = 1
      #   x = 'string'
      #
      #   # bad
      #   y = 1.0
      #   y = [1, 2, 3]
      #
      #   # good
      #   x = 1
      #   x = 2
      #
      #   # good
      #   y = 'string1'
      #   y = 'string2'
      #
      #   # good
      #   z = [1, 2, 3]
      #   z = [4, 5, 6]
      #
      # @example
      #   # bad
      #   class Example
      #     def initialize
      #       @x = 1
      #     end
      #
      #     def change_x
      #       @x = 'string'
      #     end
      #   end
      #
      #   # good
      #   class Example
      #     def initialize
      #       @x = 1
      #     end
      #
      #     def change_x
      #       @x = 2
      #     end
      #   end
      #
      #   # good
      #   class Example
      #     def initialize
      #       @x = 'initial'
      #     end
      #
      #     def change_x
      #       @x = 'changed'
      #     end
      #   end
      class VariableTypeChange < Base
        MSG = "Avoid changing the type of a variable within the same scope. " \
          "YJIT performs better when variables have a consistent type."

        def on_lvasgn(node)
          variable_name, value = *node
          current_type = value.class

          if already_assigned_type(variable_name) && already_assigned_type(variable_name) != current_type
            add_offense(node)
          end

          store_variable_type(variable_name, current_type)
        end

        private

        def store_variable_type(variable_name, type)
          @variable_types ||= {}
          @variable_types[variable_name] = type
        end

        def already_assigned_type(variable_name)
          @variable_types ||= {}
          @variable_types[variable_name]
        end
      end
    end
  end
end
