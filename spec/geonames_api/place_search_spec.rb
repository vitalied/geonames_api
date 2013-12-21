require 'spec_helper'

describe GeoNamesAPI::PlaceSearch do
  describe "::where" do
    it "should search for places dealing with ohio" do
      search = GeoNamesAPI::PlaceSearch.where(name: 'idaho', maxRows: 10)
      search.should be_present
      search.size.should == 10
      search.results.size.should == 10
    end
  end

  describe "::find_by_place_name" do
    it "should find the place by name" do
      search = GeoNamesAPI::PlaceSearch.find_by_place_name("idaho", 10)
      search.total_results_count.should > 0
      search.results.each{|place| place.name.should =~ /idaho/i }
    end
  end

  describe "::find_by_exact_place_name" do
    it "should find the place by the exact name" do
      search = GeoNamesAPI::PlaceSearch.find_by_exact_place_name('columbus', 10)
      search.total_results_count.should > 0
      search.results.each{|place| place.name.downcase.should == 'columbus' }
    end
  end

  describe "#next_page" do
    it "should grab the next page of results from the same search" do
      # the paging with 'columbus' sometimes doesn't match across the 3 pages.
      big_search = GeoNamesAPI::PlaceSearch.where(name: 'goleta', maxRows: 9)
      search_pg1 = GeoNamesAPI::PlaceSearch.where(name: 'goleta', maxRows: 3)
      search_pg2 = search_pg1.next_page
      search_pg3 = search_pg2.next_page
      search_pg1.size.should == 3
      search_pg2.size.should == 3
      search_pg3.size.should == 3
      search_pg3.request_params[:startRow].should == 6
      (search_pg1.results + search_pg2.results + search_pg3.results).map{|ea|ea.geoname_id}.should == big_search.results.map{|ea|ea.geoname_id}
    end
  end

  describe "#to_page" do
    it "should grab the specified page of results from the same search" do
      search10 = GeoNamesAPI::PlaceSearch.all("columbus", 10)
      search2 = GeoNamesAPI::PlaceSearch.all("columbus", 2)
      search2.to_page(4).first.geoname_id.should == search10.results[8].geoname_id
    end
  end
end
