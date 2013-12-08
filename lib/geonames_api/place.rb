module GeoNamesAPI
  class Place < ListEndpoint

    METHOD = "findNearbyJSON"
    FIND_PARAMS = %w(lat lng radius maxRows)

  end
end
