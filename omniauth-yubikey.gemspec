# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth-yubikey/version"

Gem::Specification.new do |s|
  s.name        = "omniauth-yubikey"
  s.version     = OmniAuth::Yubikey::VERSION
  s.authors     = ["Steve Hoeksema"]
  s.email       = ["steve@seven.net.nz"]
  s.homepage    = "https://github.com/steveh/omniauth-yubikey"
  s.summary     = "OmniAuth strategy for authenticating against the Yubico API with a Yubikey OTP"
  s.description = "OmniAuth strategy for authenticating against the Yubico API with a Yubikey OTP"

  s.rubyforge_project = "omniauth-yubikey"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "omniauth", "~> 1.0"

  s.add_development_dependency "rspec", "~> 2.7"
end
