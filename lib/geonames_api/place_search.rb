module GeoNamesAPI
  class PlaceSearch < ListEndpoint

    METHOD = 'searchJSON'
    FIND_PARAMS = %w(q maxRows)
    DEFAULT_MAX_ROWS = 100
    
    attr_reader :response

    def self.find_by_place_name(name, max_rows = DEFAULT_MAX_ROWS)
      where(name: name, maxRows: max_rows)
    end

    def self.find_by_exact_place_name(name, max_rows = DEFAULT_MAX_ROWS)
      where(name_equals: name, maxRows: max_rows)
    end
  end
end
