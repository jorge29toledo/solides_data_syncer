# frozen_string_literal: true

require_relative "lib/solides_data_syncer/version"

Gem::Specification.new do |spec|
  spec.name = "solides_data_syncer"
  spec.version = SolidesDataSyncer::VERSION
  spec.authors = ["jorge29toledo"]
  spec.email = ["jorge.toledo@solides.com.br"]

  spec.summary = "Sincronização de dados com sistemas externos."
  spec.description = "Uma gem para ajudar na sincronização de dados entre a plataforma Sólides e outros sistemas."
  spec.homepage = "https://github.com/seu_usuario/solides_data_syncer" # <- substitua com seu repositório
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # Você pode remover ou preencher com um link real depois:
  # spec.metadata["changelog_uri"] = "https://github.com/seu_usuario/solides_data_syncer/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # spec.add_dependency "rails", ">= 4.2", "< 9.0" # ← se sua gem depender de Rails

  spec.add_dependency "mongo", "~> 2.20"
  spec.add_dependency "dotenv", "~> 2.8" # se for usar .env
end
