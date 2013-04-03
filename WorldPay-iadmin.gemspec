# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'worldpay-iadmin/version'

Gem::Specification.new do |gem|
  gem.name          = "worldpay-iadmin"
  gem.version       = WorldPay::Iadmin::VERSION
  gem.authors       = ["Steven Cummings", "Aziz Light"]
  gem.email         = ["aziz@azizlight.me"]
  gem.summary       = %q{Provides an interface to WorldPays remote administration api for FuturePay agreements}
  gem.homepage      = "https://github.com/catapultcentral/WorldPay-iadmin"

  gem.add_development_dependency "fakeweb"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
