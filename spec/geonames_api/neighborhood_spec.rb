require 'spec_helper'

describe GeoNamesAPI::Neighbourhood do
  describe "::find" do
    it "should find NYC" do
      result = GeoNamesAPI::Neighbourhood.find(lat: 40.78343, lng: -73.96625)
      result.hierarchy.should == ["United States", "New York", "New York County", "New York City-Manhattan", "Central Park"]
    end

    it "should not find streets outside of the US" do
      proc { GeoNamesAPI::Neighbourhood.find(0, 0) }.should raise_error GeoNamesAPI::Error
    end
  end
end
