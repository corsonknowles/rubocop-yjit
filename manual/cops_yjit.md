# Yjit

## Yjit/LoopedAllocation

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | No | <<next>> | -

Checks for object allocations inside loops which may be hot code paths.

### Examples

```ruby
# bad
items.each do |item|
  array = []
  hash = {}
  string = ""
  object = MyClass.new
end

# good
array = []
hash = {}
string = ""
object = MyClass.new
items.each do |item|
  # use pre-allocated objects
end
```

## Yjit/MethodIndirection

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | No | <<next>> | -

Checks for trivial methods that call another method directly.
They add unnecessary indirection and reduce performance on YJIT.

### Examples

#### EnforcedStyle: bar (default)

```ruby
# Description of the `bar` style.

# bad
def some_method
  another_method
end

# bad
bad_bar_method(args)

# good
good_bar_method

# good
good_bar_method(args)
```
#### EnforcedStyle: foo

```ruby
# Description of the `foo` style.

# bad
bad_foo_method

# bad
bad_foo_method(args)

# good
good_foo_method

# good
good_foo_method(args)
```

## Yjit/RedefinedOperator

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | No | <<next>> | -

Checks for redefining basic integer operations such as `+`, `-`, `<`, `>`, etc.
This degrades performance on YJIT.

### Examples

```ruby
# bad
def +(other)
  # custom addition logic
end

# bad
def -(other)
  # custom subtraction logic
end

# bad
def <(other)
  # custom less than comparison
end

# good
def custom_addition(other)
  # custom addition logic
end

# good
def custom_subtraction(other)
  # custom subtraction logic
end

# good
def custom_less_than(other)
  # custom less than comparison
end
```

## Yjit/RedefiningEquality

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | No | <<next>> | -

Checks for redefinition of `nil?`, `==`, or `!=` methods.
Redefining these methods can negatively impact YJIT performance.

### Examples

```ruby
# bad
class MyClass
  def nil?
    # custom implementation
  end
end

# bad
class MyClass
  def ==(other)
    # custom implementation
  end
end

# bad
class MyClass
  def !=(other)
    # custom implementation
  end
end

# good
class MyClass
  def my_nil_checker?(value)
    value.nil?
  end
end

# good
class MyClass
  def custom_equality(other)
    # custom implementation that doesn't override ==, !=, or nil?
  end
end
```

## Yjit/TrivialMethod

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | No | <<next>> | -

Checks for methods that only return a constant or hash value.
These methods add unnecessary method call overhead and can be replaced
with direct constant or hash access.

### Examples

```ruby
# bad
def answer
  42
end

# bad
def pi
  3.14159
end

# bad
def get_hash
  { key: 'value' }
end

# good
ANSWER = 42

# good
PI = 3.14159

# good
HASH = { key: 'value' }

# good
def complex_calculation
  # Some non-trivial logic here
  result
end
```

## Yjit/VariableTypeChange

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | No | <<next>> | -

Checks for changes in variable types within the same scope.
YJIT performs better when variables have a consistent type.
This applies to both local variables and instance variables.

### Examples

```ruby
# bad
x = 1
x = 'string'

# bad
y = 1.0
y = [1, 2, 3]

# good
x = 1
x = 2

# good
y = 'string1'
y = 'string2'

# good
z = [1, 2, 3]
z = [4, 5, 6]
```
```ruby
# bad
class Example
  def initialize
    @x = 1
  end

  def change_x
    @x = 'string'
  end
end

# good
class Example
  def initialize
    @x = 1
  end

  def change_x
    @x = 2
  end
end

# good
class Example
  def initialize
    @x = 'initial'
  end

  def change_x
    @x = 'changed'
  end
end
```
