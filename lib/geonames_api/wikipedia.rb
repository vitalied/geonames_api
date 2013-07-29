module GeoNamesAPI
  class Wikipedia < ListEndpoint

    METHOD = "findNearbyWikipediaJSON"
    FIND_PARAMS = %W(lat lng radius maxRows)

  end
end
