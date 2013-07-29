module GeoNamesAPI
  class Street < ListEndpoint

    METHOD = "findNearbyStreetsJSON"
    FIND_PARAMS = %w(lat lng radius maxRows)

  end
end
