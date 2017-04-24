# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sped2db/version'

Gem::Specification.new do |spec|
  spec.name          = 'sped2db'
  spec.version       = Sped2DB::VERSION
  spec.authors       = ['Elvis Luciano']
  spec.email         = ['elvis.gs@gmail.com']

  spec.summary       = 'Importa registros SPED para um BD'
  spec.description   = 'Importa registros de arquivos no formato SPED e salva em um Banco de Dados'
  spec.homepage      = 'https://github.com/elvisgs/sped2db'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency 'slop', '~> 4.4.1'
  spec.add_dependency 'event_emitter', '~> 0.2.5'
  spec.add_dependency 'ruby-progressbar', '~> 1.8.1'
  spec.add_dependency 'sequel', '~> 4.7.0'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'pg', '~> 0.16.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'sqlite3', '~> 1.3.13'
end
