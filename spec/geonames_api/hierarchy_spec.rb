require 'spec_helper'

describe GeoNamesAPI::Hierarchy do
  def should_be_sb(h)
    h.first.name.should == 'Earth'
    h.map { |ea| ea.name }.should ==
      ['Earth', 'North America', 'United States', 'California', 'Santa Barbara County', 'Santa Barbara']
  end

  def should_be_roma(h)
    h.map { |ea| ea.name }.should ==
      ['Terra', 'Europa', 'Italia', 'Lazio', 'Roma', 'Roma', 'Roma']
  end

  describe '::find' do
    it 'works for Santa Barbara' do
      h = GeoNamesAPI::Hierarchy.find(5392952)
      should_be_sb(h)
    end

    it 'works for Roma ' do
      begin
        GeoNamesAPI.lang = :it
        h = GeoNamesAPI::Hierarchy.find(3169070)
        should_be_roma(h)
      ensure
        GeoNamesAPI.lang = :en
      end
    end
  end

  describe '::where' do
    it 'works for Santa Barbara' do
      h = GeoNamesAPI::Hierarchy.where(geonameId: 5392952)
      should_be_sb(h)
    end
  end
end
