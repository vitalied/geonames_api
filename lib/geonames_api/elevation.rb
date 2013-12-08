module GeoNamesAPI
  class Elevation < SingletonEndpoint

    METHOD = "astergdemJSON"
    FIND_PARAMS = %w(lat lng)

  end
end

=begin
{
  "astergdem": 192,
  "lng": 10.2,
  "lat": 50.01
}
=end
