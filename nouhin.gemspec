
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nouhin/version"

Gem::Specification.new do |spec|
  spec.name          = "nouhin"
  spec.version       = Nouhin::VERSION
  spec.authors       = ["furukaha"]
  spec.email         = ["nikkeiheikinkabuka@gmail.com"]

  spec.summary       = "納品物管理コマンドライン・ツール(CLI)"
  spec.description   = "アーカイブでソースの納品を求められる環境下で、納品対象物を管理するためのコマンド"
  spec.homepage      = "https://github.com/furukaha/nouhin"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "thor", "~> 0.20.0"
end
