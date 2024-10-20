# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Yjit::TrivialMethod, :config do
  it "registers an offense for a method that returns a constant" do
    expect_offense(<<~RUBY)
      def constant_value
      ^^^^^^^^^^^^^^^^^^ Avoid methods that only return a constant or hash value. They add unnecessary method call overhead.
        CONSTANT
      end
    RUBY
  end

  it "registers an offense for a method that returns a hash value" do
    expect_offense(<<~RUBY)
      def hash_value
      ^^^^^^^^^^^^^^ Avoid methods that only return a constant or hash value. They add unnecessary method call overhead.
        some_hash[:key]
      end
    RUBY
  end

  it "does not register an offense for methods with additional logic" do
    expect_no_offenses(<<~RUBY)
      def some_method
        value = some_hash[:key]
        value * 2
      end
    RUBY
  end
end
