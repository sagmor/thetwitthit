# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{thetwitthit}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sebastian Gamboa"]
  s.date = %q{2009-04-12}
  s.default_executable = %q{thetwitthit}
  s.description = %q{Fetches tasks from twitter and adds them to The Hit List.app}
  s.email = %q{me@sagmor.com}
  s.executables = ["thetwitthit"]
  s.extra_rdoc_files = ["bin/thetwitthit", "lib/thetwitthit/cli/helpers.rb", "lib/thetwitthit/cli.rb", "lib/thetwitthit/config.rb", "lib/thetwitthit/properties.rb", "lib/thetwitthit/version.rb", "lib/thetwitthit/worker.rb", "lib/thetwitthit.rb", "README.rdoc"]
  s.files = ["bin/thetwitthit", "lib/thetwitthit/cli/helpers.rb", "lib/thetwitthit/cli.rb", "lib/thetwitthit/config.rb", "lib/thetwitthit/properties.rb", "lib/thetwitthit/version.rb", "lib/thetwitthit/worker.rb", "lib/thetwitthit.rb", "Manifest", "Rakefile", "README.rdoc", "thetwitthit.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/SagMor/thetwitthit}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Thetwitthit", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{thetwitthit}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Fetches tasks from twitter and adds them to The Hit List.app}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<twitter>, [">= 0.5.3"])
      s.add_runtime_dependency(%q<main>, [">= 0", "= 2.8.2"])
      s.add_runtime_dependency(%q<highline>, [">= 0", "= 1.4.0"])
    else
      s.add_dependency(%q<twitter>, [">= 0.5.3"])
      s.add_dependency(%q<main>, [">= 0", "= 2.8.2"])
      s.add_dependency(%q<highline>, [">= 0", "= 1.4.0"])
    end
  else
    s.add_dependency(%q<twitter>, [">= 0.5.3"])
    s.add_dependency(%q<main>, [">= 0", "= 2.8.2"])
    s.add_dependency(%q<highline>, [">= 0", "= 1.4.0"])
  end
end
