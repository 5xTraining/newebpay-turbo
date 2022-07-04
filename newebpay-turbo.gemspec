# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include? lib

require_relative 'lib/newebpay/version'

Gem::Specification.new do |spec|
  spec.name = 'newebpay_turbo'
  spec.version = Newebpay::VERSION
  spec.authors = ['RobertChang']
  spec.email = ['fishppm0212@gmail.com']

  spec.summary = 'Light way payment tool for newebpay in rails'
  spec.description = 'Online payment processing for internet businesses by newebpay from Taiwan'
  spec.required_ruby_version = '>= 2.6.0'

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.licenses = ['MIT']
  spec.homepage = 'https://github.com/5xTraining/newebpay-turbo'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
