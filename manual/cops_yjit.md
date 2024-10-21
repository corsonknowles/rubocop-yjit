# Yjit

## Yjit/LoopedAllocation

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | No | - | -

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
Enabled | Yes | No | - | -

TODO: Write cop description and example of bad / good code. For every
`SupportedStyle` and unique configuration, there needs to be examples.
Examples must have valid Ruby syntax. Do not use upticks.

### Examples

#### EnforcedStyle: bar (default)

```ruby
# Description of the `bar` style.

# bad
bad_bar_method

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
Enabled | Yes | No | - | -

TODO: Write cop description and example of bad / good code. For every
`SupportedStyle` and unique configuration, there needs to be examples.
Examples must have valid Ruby syntax. Do not use upticks.

### Examples

#### EnforcedStyle: bar (default)

```ruby
# Description of the `bar` style.

# bad
bad_bar_method

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

## Yjit/RedefiningEquality

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | No | - | -

TODO: Write cop description and example of bad / good code. For every
`SupportedStyle` and unique configuration, there needs to be examples.
Examples must have valid Ruby syntax. Do not use upticks.

### Examples

#### EnforcedStyle: bar (default)

```ruby
# Description of the `bar` style.

# bad
bad_bar_method

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

## Yjit/TrivialMethod

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | No | - | -

TODO: Write cop description and example of bad / good code. For every
`SupportedStyle` and unique configuration, there needs to be examples.
Examples must have valid Ruby syntax. Do not use upticks.

### Examples

#### EnforcedStyle: bar (default)

```ruby
# Description of the `bar` style.

# bad
bad_bar_method

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

## Yjit/VariableTypeChange

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | No | - | -

TODO: Write cop description and example of bad / good code. For every
`SupportedStyle` and unique configuration, there needs to be examples.
Examples must have valid Ruby syntax. Do not use upticks.

### Examples

#### EnforcedStyle: bar (default)

```ruby
# Description of the `bar` style.

# bad
bad_bar_method

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
