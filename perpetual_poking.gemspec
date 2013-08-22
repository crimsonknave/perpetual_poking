# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "perpetual_poking/version"

Gem::Specification.new do |s|
  s.name = 'perpetual_poking'
  s.version = PerpetualPoking::VERSION

  s.authors = ["Joseph Henrich", "Chris Lee"]
  s.email = ['jhenrich@constantcontact.com', 'clee@constantcontact.com']
  s.homepage = %q{http://github.com/crimsonknave/perpetual_poking}
  s.summary = %q{Wrapper for the Constant Contact v2 api}
  s.description  = %q{Wrapper for the Constant Contact v2 api}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'cot', '0.1.0'
  s.add_development_dependency 'rake', '10.1.0'
  s.add_development_dependency 'shoulda', ">= 0"
  s.add_development_dependency 'bundler', ">= 1.0.0"
  s.add_development_dependency 'rspec', ">= 0"
  s.add_development_dependency 'webmock', '1.13.0'
end

