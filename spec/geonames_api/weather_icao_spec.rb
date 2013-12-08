require 'spec_helper'

describe GeoNamesAPI::WeatherICAO do
  describe "::find" do
    it "should find one station" do
      result = GeoNamesAPI::WeatherICAO.find('KHAF')
      result.should be_present
    end
  end
end
