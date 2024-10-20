# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Yjit::MethodIndirection, :config do
  it "registers an offense for a trivial method that calls another method directly" do
    expect_offense(<<~RUBY)
      def some_method
      ^^^^^^^^^^^^^^^ Avoid trivial methods that call another method directly. They add unnecessary indirection and reduce performance on YJIT.
        another_method
      end
    RUBY
  end

  it "does not register an offense for methods with additional logic" do
    expect_no_offenses(<<~RUBY)
      def some_method
        value = another_method
        value * 2
      end
    RUBY
  end

  # 1. No body in the method (nil body)
  it "does not register an offense when method has no body" do
    expect_no_offenses(<<~RUBY)
      def some_method
      end
    RUBY
  end

  # 2. Method body is not a `send_type?`
  it "does not register an offense when method body is not a method call" do
    expect_no_offenses(<<~RUBY)
      def some_method
        value = 42
      end
    RUBY
  end

  # 3. Method body is a send_type but is not a trivial method (i.e., it has a receiver that is not `self`)
  it "does not register an offense when the method is not trivial (has non-self receiver)" do
    expect_no_offenses(<<~RUBY)
      def some_method
        other_object.some_method
      end
    RUBY
  end

  # 4. Method body is a trivial method (just calls another method)
  it "registers an offense for a trivial method that calls another method directly" do
    expect_offense(<<~RUBY)
      def some_method
      ^^^^^^^^^^^^^^^ Avoid trivial methods that call another method directly. They add unnecessary indirection and reduce performance on YJIT.
        another_method
      end
    RUBY
  end

  # 5. Method body is a trivial method with `self`
  it "registers an offense for a trivial method with self" do
    expect_offense(<<~RUBY)
      def some_method
      ^^^^^^^^^^^^^^^ Avoid trivial methods that call another method directly. They add unnecessary indirection and reduce performance on YJIT.
        self.another_method
      end
    RUBY
  end
end
