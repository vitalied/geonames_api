require 'spec_helper'

describe GeoNamesAPI::PlaceName do
  describe "::find" do
    it "should find one place" do
      result = GeoNamesAPI::PlaceName.find("50.01","10.2")
      result.should be_present
    end

     it 'should find one place with a hash' do
      result = GeoNamesAPI::PlaceName.find(lat: 50.01, lng: 10.2)
      result.should be_present
    end
  end

  describe "::all" do
    it "should find maxRow places in 100km radius" do
      result = GeoNamesAPI::PlaceName.all("50.01","10.2","100", "3")
      result.count.should == 3
    end
  end
end
