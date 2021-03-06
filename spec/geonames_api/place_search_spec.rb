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
      page_size = 3
      big_search = GeoNamesAPI::PlaceSearch.where(name: 'goleta', maxRows: page_size * 4)
      search_pg1 = GeoNamesAPI::PlaceSearch.where(name: 'goleta', maxRows: page_size)
      search_pg1.size.should == page_size

      search_pg2 = search_pg1.next_page
      search_pg2.size.should == page_size
      search_pg2.request_params[:startRow].should == page_size

      search_pg3 = search_pg2.next_page
      search_pg3.request_params[:startRow].should == page_size * 2
      search_pg3.size.should == page_size

      # Ordering isn't always deterministic, so we're just looking for an overlap bigger than 1 page size:
      expected_ids = big_search.results.map { |ea| ea.geoname_id }
      paged_ids = (search_pg1.results + search_pg2.results + search_pg3.results).map { |ea| ea.geoname_id }
      matching_ids = paged_ids & expected_ids
      if matching_ids.size <= page_size
        # use .should just to render a nice error message:
        paged_ids.should =~ matching_ids
      end
    end
  end

  describe "#to_page" do
    it "should set startRow appropriately" do
      search2 = GeoNamesAPI::PlaceSearch.all("columbus", 2)
      page4 = search2.to_page(4)
      page4.request_params[:startRow].should == 8
    end
  end
end
