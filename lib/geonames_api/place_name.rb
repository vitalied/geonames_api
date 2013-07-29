module GeoNamesAPI
  class PlaceName < ListEndpoint

    METHOD = "findNearbyPlaceNameJSON"
    FIND_PARAMS = %w(lat lng radius maxRows)

  end
end
