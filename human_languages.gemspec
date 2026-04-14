# frozen_string_literal: true

require_relative 'lib/languages/version'

Gem::Specification.new do |spec|
  spec.name = 'human_languages'
  spec.version = Languages::VERSION
  spec.authors = ['Benno Bielmeier']
  spec.email = ['git@bbenno.com']

  spec.summary = 'ISO 639-3 languages'
  spec.description = 'ISO 639-3 is a set of codes that defines three-letter identifiers for all known human languages.'
  spec.homepage = 'https://github.com/bbenno/languages'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.metadata['source_code_uri']}/blob/HEAD/CHANGELOG.md"
  spec.metadata['bugs_uri'] = "#{spec.metadata['source_code_uri']}/issues"
  spec.metadata['documentation_uri'] = 'https://bbenno.github.io/languages'
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['github_repo'] = 'git@github.com:bbenno/languages.git'

  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test)/|\.(?:git|rubocop|envrc)|devenv)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency('csv', '~> 3.0')
end
