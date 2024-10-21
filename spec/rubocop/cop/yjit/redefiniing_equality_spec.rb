# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Yjit::RedefiningEquality, :config do
  it "registers an offense when redefining `nil?`" do
    expect_offense(<<~RUBY)
      def nil?
      ^^^^^^^^ Avoid redefining `nil?`, `==`, or `!=`. This can negatively impact YJIT performance.
        false
      end
    RUBY
  end

  it "registers an offense when redefining `==`" do
    expect_offense(<<~RUBY)
      def ==(other)
      ^^^^^^^^^^^^^ Avoid redefining `nil?`, `==`, or `!=`. This can negatively impact YJIT performance.
        # logic
      end
    RUBY
  end

  it "registers an offense when redefining `!=`" do
    expect_offense(<<~RUBY)
      def !=(other)
      ^^^^^^^^^^^^^ Avoid redefining `nil?`, `==`, or `!=`. This can negatively impact YJIT performance.
        # logic
      end
    RUBY
  end

  it "does not register an offense for other method definitions" do
    expect_no_offenses(<<~RUBY)
      def other_method
        # logic
      end
    RUBY
  end
end