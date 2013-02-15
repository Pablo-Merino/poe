$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
name = "poe"
require "#{name}/version"

Gem::Specification.new name, Poe::VERSION do |s|
	s.summary = "YayEditor"
	s.authors = ["Pablo Merino"]
	s.email = "pablo@wearemocha.com"
	s.homepage = "http://github.com/pablo-merino/#{name}"
	s.files = `git ls-files`.split("\n")
	s.license = "MIT"
	s.add_dependency("colored", ["~> 1.2"])  
end
