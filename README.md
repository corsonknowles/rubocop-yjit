# Rubocop-Yjit

An extension of RuboCop focused on exploratory YJIT optimizations.

## Experimental 

This repo is based on an exploration of the YJIT Performance Recommendations. Despite the official recommendation not to refactor your code base to confrom to YJIT's current limitations, and the rapid improvements of YJIT as it addresses its current constraints, some of these guidelines are generally applicable best practices (such as avoiding the use of OpenStruct in Production, which is already covered by `Performance/OpenStuct`)

Before experimenting with Rubocop-Yjit, we strongly recommend first enabling:
`Performance/OpenStuct`
`Performance/CollectionLiteralInLoop`
as these cover widely applicable best practices.

> Code Optimization Tips
This section contains tips on writing Ruby code that will run as fast as possible on YJIT. Some of this advice is based on current limitations of YJIT, while other advice is broadly applicable. It probably won't be practical to apply these tips everywhere in your codebase. You should ideally start by profiling your application using a tool such as stackprof so that you can determine which methods make up most of the execution time. You can then refactor the specific methods that make up the largest fractions of the execution time. We do not recommend modifying your entire codebase based on the current limitations of YJIT.

- Avoid using OpenStruct
- Avoid redefining basic integer operations (i.e. +, -, <, >, etc.)
- Avoid redefining the meaning of nil, equality, etc.
- Avoid allocating objects in the hot parts of your code
- Minimize layers of indirection
- Avoid classes that wrap objects if you can
- Avoid methods that just call another method, trivial one-liner methods
- Try to write code so that the same variables always have the same type
- CRuby method calls are costly. Avoid things such as methods that only return a value from a hash or return a constant.

> You can also use the --yjit-stats command-line option to see which bytecodes cause YJIT to exit, and refactor your code to avoid using these instructions in the hottest methods of your code.

[Source](https://github.com/k0kubun/ruby/blob/2471e03e5c5e4b0eb9fe36edfdf97b8f22cb424d/doc/yjit/yjit.md)

## Installation

If you use `Bundler`, add this line your application's `Gemfile`:

```ruby
gem 'rubocop-yjit', require: false
```

You can directly install the `rubocop-yjit` gem

```sh
gem install rubocop-yjit
```

## Usage

You need to tell RuboCop to load this YJIT extension. There are three ways to do this:

### RuboCop configuration file

Put this into your `.rubocop.yml`:

```yaml
require: rubocop-yjit
```

Alternatively, use the following array notation when specifying multiple extensions:

```yaml
require:
  - rubocop-other-extension
  - rubocop-yjit
```

Now you can run `rubocop` and it will automatically load the RuboCop-Yjit cops together with the standard cops.

### Command line

```sh
rubocop --require rubocop-yjit
```

### Rake task

```ruby
RuboCop::RakeTask.new do |task|
  task.requires << 'rubocop-yjit'
end
```

## The Cops
All cops are located under [`lib/rubocop/cop/yjit`](lib/rubocop/cop/yjit), and contain examples/documentation.

In your `.rubocop.yml`, you may treat the yjit cops just like any other cop. For example:

```yaml
Yjit/TrivialMethods:
  Exclude:
    - lib/example.rb
```

## Documentation

You can read about each cop supplied by RuboCop Yjit in [the manual](manual/cops.md).

## Compatibility

Yjit cops support the following versions:

- Ruby >= 3.3

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/corsonknowles/rubocop-yjit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the standard OSS norms of collegiality.

To contribute a new cop, please use the supplied generator like this:

```sh
bundle exec rake "new_cop[Yjit/NewCopName]"
```

which will create a skeleton cop, a skeleton spec, an entry in the default config file and will require the new cop so that it is properly exported from the gem.

Don't forget to update the documentation with:

```sh
bundle exec rake generate_cops_documentation
```

## License

The gem is available as open source under the terms of the MIT License.

