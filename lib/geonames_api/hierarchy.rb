module GeoNamesAPI
  # This endpoint returns a list of geonames, but it's a single hierarchy,
  # so it should be considered a singleton endpoint.
  class Hierarchy < SingletonEndpoint

    METHOD = "hierarchyJSON"
    FIND_PARAMS = %w(geonameId)

  end
end
