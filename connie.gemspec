# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{connie}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pius Uzamere"]
  s.date = %q{2009-01-06}
  s.description = %q{TODO}
  s.email = %q{pius+git@alum.mit.edu}
  s.files = ["README.markdown", "VERSION.yml", "lib/connie.rb", "spec/spec.opts", "spec/spec_helper.rb", "spec/unit", "spec/unit/basic_select_spec.rb"]
  s.homepage = %q{http://github.com/pius/connie}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
