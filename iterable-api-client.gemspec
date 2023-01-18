# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name                  = 'iterable-api-client'
  s.version               = '0.5.0'
  s.summary               = 'Iterable REST API Client'
  s.description           = 'Ruby gem for the Iterable REST API'
  s.licenses              = %w[MIT]
  s.authors               = %w[Chavez]
  s.email                 = 'contact@el-chavez.me'
  s.files                 = Dir.glob('{bin,lib}/**/*') + %w[README.md]
  s.require_paths         = %w[lib]
  s.homepage              = 'https://gitlab.com/mtchavez/iterable'
  s.rdoc_options          = %w[--charset=UTF-8 --main=README.md]
  s.extra_rdoc_files      = %w[README.md]
  s.required_ruby_version = '>= 2.6.0'
  s.cert_chain            = %w[certs/mtchavez.pem]
  s.signing_key           = File.join(Gem.user_home, '.ssh', 'gem-private_key.pem') if $PROGRAM_NAME.end_with?('gem')

  # Runtime dependencies
  s.add_dependency 'multi_json', '>= 1.12.0'

  # Dev Dependencies
  s.add_development_dependency 'dotenv',              '~> 2.7.1'
  s.add_development_dependency 'gemcutter',           '~> 0.7.1'
  s.add_development_dependency 'pry',                 '~> 0.14.1'
  s.add_development_dependency 'pry-byebug',          '~> 3.8.0'
  s.add_development_dependency 'pry-doc',             '~> 1.3.0'
  s.add_development_dependency 'rake',                '~> 13.0.0'
  s.add_development_dependency 'redcarpet',           '~> 3.5.0'
  s.add_development_dependency 'rspec',               '~> 3.11.0'
  s.add_development_dependency 'rubocop',             '~> 1.29.1'
  s.add_development_dependency 'rubocop-performance', '~> 1.13.3'
  s.add_development_dependency 'rubocop-rspec',       '~> 2.11.0'
  s.add_development_dependency 'simplecov',           '~> 0.21.2'
  s.add_development_dependency 'simplecov-cobertura', '~> 2.1.0'
  s.add_development_dependency 'typhoeus',            '~> 1.4.0'
  s.add_development_dependency 'vcr',                 '~> 3.0.3'
  s.add_development_dependency 'webmock',             '~> 3.14.0'
  s.add_development_dependency 'yard',                '~> 0.9.11'
  s.metadata['rubygems_mfa_required'] = 'true'
end
