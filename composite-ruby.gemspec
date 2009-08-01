# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{composite-ruby}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Fred George"]
  s.date = %q{2009-08-01}
  s.description = %q{These class(es) ease the ability to implement a Composite pattern [GoF] and a supporting Visitor pattern [GoF].
Pattern::Composite extends Enumerable, allowing rich iteration across the children of the Composite. 
Composite patterns are useful anywhere there is a hierarchy or tree.  Examples include organization
structures, parse trees for expressions, and anytime a collection of a collection (of a collection, 
etc.) occurs.

  require 'composite-ruby'
  class MyClass
    include Pattern::Composite
    ...
  end

Mixed-in methods include:
  <<(child)             - add a sub-component
  add(child)            - alias for <<
  each                  - iterating through children
  total(:accessor)      - sum the values of the specified accessor of the leaves
  aggregate(:accessor)  - return an array of all elements of the specified accessor of the leaves
  collecting(:accessor) - return a merged collection of all the collections from the leaves
  
In addition, recursive accessors can be created.  For example for totaling the values in leaves:

  class MyClass
    include Pattern::Composite
    recursive_total :var1, :var2, ...
    ...
  end
    
This creates recursive methods that return the total all the values of var1 in the leaves.  See
the RSpec test, spec/unbalanced_composite_spec.rb, for a comprehensive example of usage.}
  s.email = ["fredgeorge@acm.org"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "lib/composite-ruby.rb", "script/console", "script/destroy", "script/generate", "spec/spec_helper.rb", "spec/simple_composite_spec.rb", "spec/unbalanced_composite_spec.rb", "spec/helpers/number_tree.rb", "spec/helpers/organization.rb"]
  s.homepage = %q{http://github.com/fredgeorge/composite-ruby}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{composite-ruby}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{These class(es) ease the ability to implement a Composite pattern [GoF] and a supporting Visitor pattern [GoF]}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec>, [">= 1.2.6"])
      s.add_development_dependency(%q<hoe>, [">= 2.3.2"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.6"])
      s.add_dependency(%q<hoe>, [">= 2.3.2"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.6"])
    s.add_dependency(%q<hoe>, [">= 2.3.2"])
  end
end
