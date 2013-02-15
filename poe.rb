# encoding: utf-8
require 'active_support/core_ext/string'


module Poe; end

File.tap do |f|
	Dir[f.expand_path(f.join(f.dirname(__FILE__),'lib', 'poe', '**/*.rb'))].each do |file|

		Poe.autoload File.basename(file, '.rb').camelize, file
	end
end

