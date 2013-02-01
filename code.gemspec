$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
name = "code"
require "#{name}/version"

Gem::Specification.new name, Code::VERSION do |s|
  s.summary = "YayEditor"
  s.authors = ["Pablo Merino"]
  s.email = "pablo@wearemocha.com"
  s.homepage = "http://github.com/pablo-merino/#{name}"
  s.files = `git ls-files`.split("\n")
  s.license = "MIT"
end
