# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth/yubikey/version"

Gem::Specification.new do |s|
  s.name        = "oa-yubikey"
  s.version     = OmniAuth::Yubikey::VERSION
  s.authors     = ["Steve Hoeksema"]
  s.email       = ["steve@seven.net.nz"]
  s.homepage    = "https://github.com/steveh/oa-yubikey"
  s.summary     = "OmniAuth strategy for authenticating against the Yubico API with a Yubikey OTP"
  s.description = "OmniAuth strategy for authenticating against the Yubico API with a Yubikey OTP"

  s.rubyforge_project = "oa-yubikey"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rack"
  s.add_development_dependency "rspec"

  s.add_runtime_dependency "oa-core"
end
