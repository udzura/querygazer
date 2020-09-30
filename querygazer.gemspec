require_relative 'lib/querygazer/version'

Gem::Specification.new do |spec|
  spec.name          = "querygazer"
  spec.version       = Querygazer::VERSION
  spec.authors       = ["Uchio Kondo"]
  spec.email         = ["udzura@udzura.jp"]

  spec.summary       = %q{Repeated Query Runner}
  spec.description   = %q{Repeated Query Runner - for monitoring, operation and CI.}
  spec.homepage      = "https://github.com/udzura/querygazer"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rspec', '~> 3.0'
  spec.add_dependency 'rspec-its'
  spec.add_dependency 'rspec-expectations', '~> 3.0'
  spec.add_dependency 'rspec-mocks', '~> 3.0'
  spec.add_dependency 'google-cloud-storage', '~> 1.0'
  spec.add_dependency 'google-cloud-bigquery', '~> 1.0'
end
