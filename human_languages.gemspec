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
  spec.required_ruby_version = '>= 3.1.0'

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.metadata['source_code_uri']}/blob/HEAD/CHANGELOG.md"
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['github_repo'] = 'git@github.com:bbenno/languages.git'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci|envrc)|devenv|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
