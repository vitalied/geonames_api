# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'geonames_api/version'

Gem::Specification.new do |gem|
  gem.name          = "geonames_api"
  gem.version       = GeoNamesAPI::VERSION
  gem.authors       = ["Sean Devine", "Matthew McEachen"]
  gem.email         = ["barelyknown@icloud.com", "matthew-github@mceachen.org"]
  gem.description   = %q{Simple ruby client for the GeoNames API to get free and easy geographic info.}
  gem.summary       = %q{This is a lightweight client for the GeoNames API. Huge thanks to them for such a great service! There are many GeoNames API clients. BUT, most are rewritten versions of a Java API whose interface is a little funny =| This is a simplified ruby implementation that does not implement the entire API. But, it's lightweight and has a nice interface and will be easy to extend :)}
  gem.homepage      = "https://github.com/buytruckload/geonames_api"
  
  gem.add_runtime_dependency "activesupport"
  gem.add_runtime_dependency "tzinfo"
  gem.add_runtime_dependency "rubyzip"
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
