module GeoNamesAPI
  class City < ListEndpoint

    METHOD = "citiesJSON"
    FIND_PARAMS = %w(north south east west maxRows)

  end
end
