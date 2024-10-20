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
      class VariableTypeChange < Base
        MSG = "Avoid changing the type of a variable within the same scope. YJIT performs better when variables have a consistent type."

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
