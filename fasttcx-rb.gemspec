# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fasttcx/version"

Gem::Specification.new do |spec|
  spec.name          = "fasttcx"
  spec.version       = FastTCX::VERSION
  spec.authors       = ["Jonathan Simpson"]
  spec.email         = ["jsimpson.github@gmail.com"]

  spec.summary       = %q{Ruby bindings to libfasttcx.}
  spec.description   = %q{Ruby Ruby bindings to libfasttcx.}
  spec.homepage      = "https://github.com/intouchhealth/fms2-api-ruby"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10.4"
  spec.add_development_dependency "pry-byebug", "~> 3.4.2"

  spec.add_dependency "ffi"
end
