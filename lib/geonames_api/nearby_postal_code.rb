module GeoNamesAPI
  class NearbyPostalCode < ListEndpoint

    #radius in km
    METHOD = "findNearbyPostalCodesJSON"
    FIND_PARAMS = %w(postalcode country radius maxRows)

    def self.find_all_by_lat_lng(lat, lng, radius=10, maxRows=5)
      where({
        'lat' => lat,
        'lng' => lng,
        'radius' => radius,
        'maxRows' => maxRows
      }).collect { |response| PostalCode.new(response) if response }.compact
    end
  end
end
