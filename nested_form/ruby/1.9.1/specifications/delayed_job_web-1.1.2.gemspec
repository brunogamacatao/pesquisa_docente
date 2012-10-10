# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "delayed_job_web"
  s.version = "1.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Erick Schmitt"]
  s.date = "2012-05-18"
  s.description = "Web interface for delayed_job inspired by resque"
  s.email = "ejschmitt@gmail.com"
  s.executables = ["delayed_job_web"]
  s.extra_rdoc_files = ["LICENSE.txt", "README.markdown"]
  s.files = ["bin/delayed_job_web", "LICENSE.txt", "README.markdown"]
  s.homepage = "http://github.com/ejschmitt/delayed_job_web"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.15"
  s.summary = "Web interface for delayed_job"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, [">= 0.9.2"])
      s.add_runtime_dependency(%q<haml>, ["~> 3.1.3"])
      s.add_runtime_dependency(%q<activerecord>, ["> 3.0.0"])
      s.add_runtime_dependency(%q<delayed_job>, ["> 2.0.3"])
      s.add_runtime_dependency(%q<rdoc>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<rack-test>, [">= 0"])
    else
      s.add_dependency(%q<sinatra>, [">= 0.9.2"])
      s.add_dependency(%q<haml>, ["~> 3.1.3"])
      s.add_dependency(%q<activerecord>, ["> 3.0.0"])
      s.add_dependency(%q<delayed_job>, ["> 2.0.3"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<rack-test>, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>, [">= 0.9.2"])
    s.add_dependency(%q<haml>, ["~> 3.1.3"])
    s.add_dependency(%q<activerecord>, ["> 3.0.0"])
    s.add_dependency(%q<delayed_job>, ["> 2.0.3"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<rack-test>, [">= 0"])
  end
end
