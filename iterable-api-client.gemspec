# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name                  = 'iterable-api-client'
  s.version               = '0.5.1'
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
  s.required_ruby_version = '>= 3.0.0'
  s.cert_chain            = %w[certs/mtchavez.pem]
  s.signing_key           = File.join(Gem.user_home, '.ssh', 'gem-private_key.pem') if $PROGRAM_NAME.end_with?('gem')

  # Runtime dependencies
  s.add_dependency 'multi_json', '>= 1.12.0'
  s.add_dependency 'sorbet-runtime'

  s.metadata['rubygems_mfa_required'] = 'true'
end
