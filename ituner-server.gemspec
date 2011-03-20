# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "ituner/server/version"

Gem::Specification.new do |s|
  
  s.name        = "ituner-server"
  s.version     = ITuner::Server::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["TODO: Write your name"]
  s.email       = ["TODO: Write your email address"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "ituner-server"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_runtime_dependency "ituner"
  s.add_runtime_dependency "sinatra", "~> 1.2.0"
  s.add_runtime_dependency "haml"
  s.add_runtime_dependency "sequel"
  s.add_runtime_dependency "sqlite3"
  s.add_runtime_dependency "thin"

end
