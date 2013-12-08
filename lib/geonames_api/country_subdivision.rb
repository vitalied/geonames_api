module GeoNamesAPI
  class CountrySubdivision < SingletonEndpoint

    METHOD = "countrySubdivisionJSON"
    FIND_PARAMS = %w(lat lng)

  end
end
