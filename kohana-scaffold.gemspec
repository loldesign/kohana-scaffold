$:.push File.expand_path("../lib", __FILE__)
require "kohana-scaffold/version"

Gem::Specification.new do |s|
  s.name      = "kohana-scaffold"
  s.version   = KohanaScaffold::VERSION
  s.platform  = Gem::Platform::RUBY
  s.authors   = ["Marco Antônio Singer"]
  s.email     = "markaum@gmail.com"
  s.summary   = "Kohana Scaffold"

  s.add_dependency('thor', '0.18.1')
  s.add_dependency('activesupport', "4.0.0")

  s.add_development_dependency('rspec', '2.13.0')
  s.add_development_dependency('simplecov', '0.7.1')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = ['kohana']
  s.require_paths = ["lib"]
end
