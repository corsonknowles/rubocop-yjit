# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Yjit::LoopedAllocation, :config do
  it "registers an offense for array allocation inside a loop" do
    expect_offense(<<~RUBY)
      items.each do
        array = []
        ^^^^^^^^^^ Avoid object allocations (e.g., array, hash, string, Class.new) inside loops which may be hot code paths.
      end
    RUBY
  end

  it "registers an offense for array allocation inside a numblock map" do
    expect_offense(<<~RUBY)
      items.map do
        array = [_1]
        ^^^^^^^^^^^^ Avoid object allocations (e.g., array, hash, string, Class.new) inside loops which may be hot code paths.
      end
    RUBY
  end

  it "registers an offense for hash allocation inside a loop" do
    expect_offense(<<~RUBY)
      items.each do
        hash = {}
        ^^^^^^^^^ Avoid object allocations (e.g., array, hash, string, Class.new) inside loops which may be hot code paths.
      end
    RUBY
  end

  it "registers an offense for string allocation inside a loop" do
    expect_offense(<<~RUBY)
      items.each do
        str = "new string"
        ^^^^^^^^^^^^^^^^^^ Avoid object allocations (e.g., array, hash, string, Class.new) inside loops which may be hot code paths.
      end
    RUBY
  end

  it "registers an offense for custom object allocation inside a loop" do
    expect_offense(<<~RUBY)
      items.each do
        obj = SomeClass.new
        ^^^^^^^^^^^^^^^^^^^ Avoid object allocations (e.g., array, hash, string, Class.new) inside loops which may be hot code paths.
      end
    RUBY
  end

  it "registers offenses for allocations inside a map loop" do
    expect_offense(<<~RUBY)
      items.map do
        hash = {}
        ^^^^^^^^^ Avoid object allocations (e.g., array, hash, string, Class.new) inside loops which may be hot code paths.
        str = "new string"
        ^^^^^^^^^^^^^^^^^^ Avoid object allocations (e.g., array, hash, string, Class.new) inside loops which may be hot code paths.
        obj = SomeClass.new
        ^^^^^^^^^^^^^^^^^^^ Avoid object allocations (e.g., array, hash, string, Class.new) inside loops which may be hot code paths.
      end
    RUBY
  end

  it "does not register an offense for simple value assignments inside a loop" do
    expect_no_offenses(<<~RUBY)
      items.each do
        number = 42
      end
    RUBY
  end

  it "does not register an offense for object allocations outside of a loop" do
    expect_no_offenses(<<~RUBY)
      array = []
      hash = {}
      str = "new string"
    RUBY
  end

  it "does not register an offense for other code inside a loop" do
    expect_no_offenses(<<~RUBY)
      items.each do
        perform_action
      end
    RUBY
  end

  it "does not register an offense for empty blocks" do
    expect_no_offenses(<<~RUBY)
      items.each do
      end
    RUBY
  end

  it "does not register an offense for non-enumarable blocks" do
    expect_no_offenses(<<~RUBY)
      items { |item| item }
    RUBY
  end
end
