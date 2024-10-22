# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Yjit::VariableTypeChange, :config do
  it "registers an offense for changing a variable type within the same scope" do
    expect_offense(<<~RUBY)
      value = 1
      value = "string"
      ^^^^^^^^^^^^^^^^ Avoid changing the type of a variable within the same scope. YJIT performs better when variables have a consistent type.
    RUBY
  end

  it "does not register an offense when variable type is consistent" do
    expect_no_offenses(<<~RUBY)
      value = 1
      value = 2
    RUBY
  end

  # TODO: fix this to allow different scopes
  it "registers an offense when variable exists in two parallel scopes" do
    expect_offense(<<~RUBY)
      my_method do
        value = 1
      end

      my_block_method do
        value = "string"
        ^^^^^^^^^^^^^^^^ Avoid changing the type of a variable within the same scope. YJIT performs better when variables have a consistent type.
      end
    RUBY
  end

  it "registers an offense for changing a variable type within a child scope" do
    expect_offense(<<~RUBY)
      value = 1
      my_block_method do
        value = "string"
        ^^^^^^^^^^^^^^^^ Avoid changing the type of a variable within the same scope. YJIT performs better when variables have a consistent type.
      end
    RUBY
  end
end
