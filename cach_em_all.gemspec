$:.push File.expand_path('../lib', __FILE__)
require 'cach_em_all/version'

Gem::Specification.new do |s|
  s.name        = 'cach_em_all'
  s.version     = CachEmAll::VERSION
  s.authors     = ['Oscar Esgalha']
  s.email       = ['oscaresgalha@gmail.com']
  s.homepage    = 'http://github.com/obranchr/cach_em_all'
  s.summary     = 'Fragment cache helpers for rails 4.'
  s.description = "CachEmAll is a gem which aims to make the use of Rails 4's fragment caching even easier."
  s.license     = 'MIT'

  s.files = Dir['lib/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/*.rb']

  s.add_dependency 'rails', '~> 4.0.0'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails', '~> 4.0'
end
