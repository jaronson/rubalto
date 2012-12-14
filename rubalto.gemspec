# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rubalto/version"

Gem::Specification.new do |s|
  s.name        = "rubalto"
  s.version     = Rubalto::VERSION
  s.authors     = ["Josh Aronson"]
  s.email       = ["jparonson@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby Parser for the ALTO format. See: http://www.loc.gov/standards/alto/techcenter/structure.php}
  s.description = %q{Ruby Parser for the ALTO format. See: http://www.loc.gov/standards/alto/techcenter/structure.php}

  s.rubyforge_project = "rubalto"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'pry'
  s.add_runtime_dependency 'nokogiri'
  s.add_runtime_dependency 'erubis'

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
