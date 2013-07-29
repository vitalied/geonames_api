module GeoNamesAPI
  class Earthquake < ListEndpoint

    METHOD = "earthquakesJSON"
    FIND_PARAMS = %w(north east south west date minMagnitude maxRows)

  end
end
