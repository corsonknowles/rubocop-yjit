# frozen_string_literal: true

module RuboCop
  module Cop
    module Yjit
      # Checks for object allocations inside loops which may be hot code paths.
      #
      # @example
      #   # bad
      #   items.each do |item|
      #     array = []
      #     hash = {}
      #     string = ""
      #     object = MyClass.new
      #   end
      #
      #   # good
      #   array = []
      #   hash = {}
      #   string = ""
      #   object = MyClass.new
      #   items.each do |item|
      #     # use pre-allocated objects
      #   end
      class LoopedAllocation < Base
        # Compare and contrast with:
        # https://github.com/rubocop/rubocop-performance/blob/master/lib/rubocop/cop/performance/collection_literal_in_loop.rb#L34
        ENUMERABLE_METHOD_NAMES = (Enumerable.instance_methods + [:each]).to_set.freeze
        MSG = "Avoid object allocations (e.g., array, hash, string, Class.new)" \
          " inside loops which may be hot code paths."

        def on_block(node)
          # We assume the block is likely a loop if it's used with `.each`, `.map`. This list can be expanded.
          return unless node.method_name && ENUMERABLE_METHOD_NAMES.include?(node.method_name)

          node.each_descendant(:lvasgn) do |assignment_node|
            check_for_allocation(assignment_node)
          end
        end
        alias on_numblock on_block

        private

        def check_for_allocation(node)
          assigned_value = node.children[1]
          return unless allocation?(assigned_value)

          add_offense(node)
        end

        def new_type?(node)
          node.send_type? && node.method?(:new)
        end

        def allocation?(node)
          node.array_type? || node.hash_type? || node.str_type? || new_type?(node)
        end
      end
    end
  end
end
