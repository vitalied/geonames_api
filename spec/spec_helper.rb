$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'geonames_api'

RSpec.configure do |config|
  if ENV['GEONAMES_USER']
    GeoNamesAPI.username = ENV['GEONAMES_USER']
  else
    puts "Enter your GeoNames WebServices username for running functional specs (press enter to just use default)"
    name = $stdin.gets.chomp
    GeoNamesAPI.username = name if name.present?
  end
  GeoNamesAPI.logger = Logger.new("test.log")
  GeoNamesAPI.retries = 10
  GeoNamesAPI.max_sleep_time_between_retries = 60
end
