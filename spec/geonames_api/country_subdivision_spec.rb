require 'spec_helper'


describe GeoNamesAPI::CountrySubdivision do
  def should_be_sf(result)
    result.should be_present
    result.admin_code1.should == 'CA'
    result.admin_name1.should == 'California'
    result.country_code.should == 'US'
    result.country_name.should == 'United States'
  end

  describe '::find' do
    it 'should find one subdivision' do
      result = GeoNamesAPI::CountrySubdivision.find(37.8, -122.4)
      should_be_sf(result)
    end
  end

  describe '::all' do
    it 'should find multiple subdivisions' do
      result = GeoNamesAPI::CountrySubdivision.all(37.8, -122.4)
      result.size.should > 0
      should_be_sf(result.first)
    end
  end
end
