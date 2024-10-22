# frozen_string_literal: true

require_relative "lib/rubocop/yjit/version"

Gem::Specification.new do |spec|
  spec.name          = "rubocop-yjit"
  spec.version       = RuboCop::Yjit::VERSION
  spec.authors       = ["David Corson-Knowles"]

  spec.summary       = "Experimental YJIT code checks."
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 3.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("rubocop", ">= 1")
end
