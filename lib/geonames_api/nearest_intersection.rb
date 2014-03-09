module GeoNamesAPI
  class NearestIntersection < SingletonEndpoint

    METHOD = "findNearestIntersectionJSON"
    FIND_PARAMS = %w(lat lng)

  end
end

