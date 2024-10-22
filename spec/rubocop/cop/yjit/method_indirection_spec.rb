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

  it "registers an offense for a trivial method with self" do
    expect_offense(<<~RUBY)
      def some_method
      ^^^^^^^^^^^^^^^ Avoid trivial methods that call another method directly. They add unnecessary indirection and reduce performance on YJIT.
        self.another_method
      end
    RUBY
  end

  it "does not register an offense when the method is not trivial (has non-self receiver) i.e. message passing" do
    expect_no_offenses(<<~RUBY)
      def some_method
        other_object.some_method
      end
    RUBY
  end

  it "does not register an offense when method has no body - empty edge case" do
    expect_no_offenses(<<~RUBY)
      def some_method
      end
    RUBY
  end

  it "does not register an offense when methods call multiple methods" do
    expect_no_offenses(<<~RUBY)
      def some_method
        another_method
        self.another_method
      end

      def some_other_method
        another_method
        yet_another_method
        self.another_method
      end
    RUBY
  end

  it "does not register an offense when method body is not a method call" do
    expect_no_offenses(<<~RUBY)
      def some_method
        value = 42
      end
    RUBY
  end

  it "does not register an offense for methods with additional logic" do
    expect_no_offenses(<<~RUBY)
      def some_method
        value = another_method
        value * 2
      end

      def some_sideeffect_method
        @value = :initialized; another_method
      end
    RUBY
  end
end
