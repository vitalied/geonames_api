module GeoNamesAPI
  class WeatherICAO < SingletonEndpoint

    METHOD = 'weatherIcaoJSON'
    FIND_PARAMS = %w(ICAO)

  end
end
