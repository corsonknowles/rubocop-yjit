# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Yjit::RedefinedOperator, :config do
  described_class::BASIC_OPERATIONS.each do |operation|
    it "registers an offense when redefining basic integer operation `#{operation}`" do
      # Dynamically calculate the number of caret characters for proper alignment
      caret_position = "def #{operation}(other)".size
      offense_message = "^" * caret_position + " Avoid redefining basic integer operations such as" \
        " `+`, `-`, `<`, `>`, etc. It degrades performance on YJIT."

      expect_offense(<<~RUBY, offense_message: offense_message)
        def #{operation}(other)
        %{offense_message}
          # logic
        end
      RUBY
    end
  end

  it "does not register an offense for other method definitions" do
    expect_no_offenses(<<~RUBY)
      def custom_method
        # logic
      end
    RUBY
  end
end
