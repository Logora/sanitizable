# frozen_string_literal: true

require_relative "lib/sanitizable/version"

Gem::Specification.new do |spec|
  spec.name = "sanitizable"
  spec.version = Sanitizable::VERSION
  spec.authors = ["Henry Boisgibault"]
  spec.email = ["henry@logora.fr"]

  spec.summary = "A simple sanitizer for Rails models"
  spec.description = 'A gem to help sanitize input for any Rails model by providing a `sanitizable` concern'
  spec.homepage = "https://github.com/Logora/sanitizable"
  spec.license       = 'MIT'

  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata = {
    'source_code_uri' => 'https://github.com/Logora/sanitizable',
    'homepage_uri' => 'https://github.com/Logora/sanitizable',
    'bug_tracker_uri' => 'https://github.com/Logora/sanitizable/issues'
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  spec.add_dependency 'rails-html-sanitizer', '~> 1.5'
  spec.add_dependency 'activerecord', '>= 6.1'

  spec.add_development_dependency 'rspec-rails'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
