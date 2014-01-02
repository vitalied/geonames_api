require 'spec_helper'

describe GeoNamesAPI::Base do
  describe "retries" do
    before :each do
      GeoNamesAPI.max_sleep_time_between_retries = 0
      @timeout = JSON.load <<-JSON
        {
          "status": {
            "message": "ERROR: canceling statement due to statement timeout",
            "value": 13
          }
        }
      JSON
      # This is not a correct, complete response, but that's not relevant to the spec:
      @response = JSON.load <<-JSON
        {"geonames": [{ "name": "Earth" }]}
      JSON
    end

    it "retries when geonames returns timeout errors" do
      GeoNamesAPI::Hierarchy.stub(:make_request).and_return(@timeout, @response)
      hierarchy = GeoNamesAPI::Hierarchy.find(6295630)
      earth = hierarchy.first
      earth.should be_present
      earth.name.should == "Earth"
    end

    it "fails when geonames returns timeout errors too many times" do
      GeoNamesAPI::Hierarchy.stub(:make_request).and_return(@timeout, @timeout, @response)
      GeoNamesAPI.retries = 1
      proc { GeoNamesAPI::Hierarchy.find(6295630) }.should raise_error GeoNamesAPI::Timeout
    end
  end
end
