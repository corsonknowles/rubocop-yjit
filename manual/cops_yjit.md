# Yjit

## Yjit/AllocationsInLoops

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
