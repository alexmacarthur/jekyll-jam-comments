# frozen_string_literal: true

require_relative "lib/jekyll-jam-comments/version"

Gem::Specification.new do |spec|
  spec.name             = "jekyll-jam-comments"
  spec.version          = Jekyll::JamComments::VERSION
  spec.authors          = ["Alex MacArthur"]
  spec.email            = ["alex@macarthur.me"]
  spec.summary          = "A Jekyll plugin for setting up JamComments in a Jekyll site."
  spec.homepage         = "https://github.com/alexmacarthur/jekyll-jam-comments"
  spec.license          = "MIT"

  spec.files            = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README.md", "LICENSE.txt"]
  spec.test_files       = spec.files.grep(%r!^spec/!)
  spec.require_paths    = ["lib"]

  spec.required_ruby_version = ">= 2.5.0"

  spec.add_dependency "jekyll", ">= 3.7", "< 5.0"
  spec.add_dependency "httparty"
  spec.add_dependency "pry"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop-jekyll"
end
