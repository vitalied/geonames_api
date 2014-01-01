module GeoNamesAPI
  class Neighbourhood < SingletonEndpoint
    METHOD = 'neighbourhoodJSON'
    FIND_PARAMS = %w(lat lng)

    def hierarchy
      %w{countryName adminName1 adminName2 city name}.map do |ea|
        @neighbourhood[ea]
      end
    end
  end
end

=begin

{
  "neighbourhood": {
    "countryName": "United States",
    "adminName1": "New York",
    "adminName2": "New York County",
    "city": "New York City-Manhattan",
    "name": "Central Park",
    "adminCode2": "061",
    "adminCode1": "NY",
    "countryCode": "US"
  }
}

or

{
  "status": {
    "message": "we are afraid we could not find a neighbourhood for latitude and longitude :XXX, YYYY",
    "value": 15
  }
}

=end
