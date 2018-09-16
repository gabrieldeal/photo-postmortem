# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'photo/postmortem/version'

Gem::Specification.new do |spec| # rubocop:disable Metrics/BlockLength
  spec.name          = 'photo-postmortem'
  spec.version       = Photo::Postmortem::VERSION
  spec.authors       = ['Gabriel M Deal']
  spec.email         = ['gabriel@dicksonlabs.com']

  spec.summary       = 'Tools for analyzing the photographs from a photo trip.'
  spec.description   = 'Command line apps that create semi-useful graphs and' \
                       ' spreadsheets given a set of photos that were all' \
                       ' taken on the same trip.'
  spec.homepage      = 'https://github.com/gabrielmdeal/photo-postmortem'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either
  # set the 'allowed_push_host' to allow pushing to a single host or
  # delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'byebug', '~> 9.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.49'

  spec.add_runtime_dependency 'activesupport', '~> 5.1'
  spec.add_runtime_dependency 'exif', '~> 1.0'
  spec.add_runtime_dependency 'mini_exiftool_vendored', '~> 9.2'
  spec.add_runtime_dependency 'spreadsheet', '~> 1.1'
end
