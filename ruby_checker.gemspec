# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "ruby_checker/version"

Gem::Specification.new do |spec|
  spec.name          = "ruby_checker"
  spec.version       = RubyChecker::VERSION
  spec.authors       = ["Miquel Sabaté Solà"]
  spec.email         = ["mikisabate@gmail.com"]
  spec.description   = "Ruby interpreter and version checker."
  spec.summary       = "Allows developers to check for a specific required ruby version."
  spec.homepage      = "https://github.com/mssola/ruby_checker"
  spec.license       = "LGPL-3.0"

  spec.files         = Dir["lib/**/*"] + Dir["*.md"] + Dir["COPYING*"] +
                       %w[Gemfile Rakefile ruby_checker.gemspec]
  spec.test_files    = spec.files.grep("^test/")
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.3"

  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency "git_validation_task", "~> 1.0.0"
  spec.add_development_dependency "minitest", "~> 5.14.0"
  spec.add_development_dependency "rake", "~> 13.0.1"
  spec.add_development_dependency "rubocop", "~> 0.80.1"
  spec.add_development_dependency "rubocop-minitest", "~> 0.8.0"
end
