$:.push File.expand_path("../lib", __FILE__)
require "cach_em_all/version"

Gem::Specification.new do |s|
  s.name        = "cach_em_all"
  s.version     = CachEmAll::VERSION
  s.authors     = ["Oscar Esgalha"]
  s.email       = ["oscaresgalha@gmail.com"]
  s.homepage    = "http://github.com/obranchr/cach_em_all"
  s.summary     = "Fragment cache helpers for rails."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"

  s.add_development_dependency "sqlite3"
end
