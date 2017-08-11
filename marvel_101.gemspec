# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "marvel_101/version"

Gem::Specification.new do |spec|
  spec.name          = "marvel_101"
  spec.version       = Marvel101::VERSION
  spec.authors       = ["Tyler Buchheim"]
  spec.email         = ["tbuchhei@alumni.nd.edu"]

  spec.summary       = "Marvel.com scraper CLI"
  spec.description   = "A CLI that scrapes marvel.com for info on popular Marvel characters and teams."
  spec.homepage      = "https://github.com/buchheimt/marvel_101"
  spec.license       = "MIT"
  spec.executables  << "marvel_101"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  gem 'nokogiri', "~> 1.8"
  gem 'pry', "~> 0.10"
  gem 'launchy', "~> 2.4"

  spec.add_dependency 'bundler', "~> 1.15"
  spec.add_dependency 'nokogiri', "~> 1.8"
  spec.add_dependency 'pry', "~> 0.10"
  spec.add_dependency 'launchy', "~> 2.4"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
