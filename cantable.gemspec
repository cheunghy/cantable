$:.push File.expand_path("../lib", __FILE__)
require "cantable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cantable"
  s.version     = Cantable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.license     = "MIT"

  s.summary     = "Generate privileges table from cancancan"
  s.description = "Generate privileges table from cancancan"
  s.authors     = ["Cheung Hoi Yu"]
  s.email       = ["yeannylam@gmail.com"]
  s.homepage    = "https://github.com/cheunghoiyu/cantable"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "railties", ">= 4.0.0", "< 5"
  s.add_dependency "cancancan", "~> 1.9.2"

end
