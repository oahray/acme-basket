Gem::Specification.new do |spec|
  spec.required_ruby_version = '>= 3.0'
  spec.name          = 'acme_basket'
  spec.version       = '0.1.0'
  spec.summary       = 'Acme Widget Co Basket'
  spec.authors       = ['Oare Arene']

  spec.files         = Dir['lib/**/*.rb']
  spec.executables   = ['console']
  spec.require_paths = ['lib']

  spec.add_dependency 'pry'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
