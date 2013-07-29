module GeoNamesAPI
  class CountryCode < SingletonEndpoint

    METHOD = "countryCodeJSON"
    FIND_PARAMS = %w(lat lng type lang radius)

  end
end
