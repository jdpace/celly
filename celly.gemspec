# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "celly/version"

Gem::Specification.new do |s|
  s.name        = "celly"
  s.version     = Celly::VERSION
  s.authors     = ["Jared Pace"]
  s.email       = ["jared@codeword.io"]
  s.homepage    = ""
  s.summary     = %q{Sends a reimbursement form for your ATT cell phone bill}
  s.description = %q{Automate sending reimbursement forms for your cell phone account, if your company does that sort of thing}

  s.rubyforge_project = "celly"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"

  s.add_runtime_dependency 'capybara'
  s.add_runtime_dependency 'capybara-webkit'
end
