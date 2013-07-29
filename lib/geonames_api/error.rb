module GeoNamesAPI
  class Error < StandardError
    # See http://www.geonames.org/export/webservice-exception.html
    def self.from_status(status)
      val = status['value'].to_i
      error_type = case val
        when 12, 13, 22
          Timeout
        when 14
          InvalidParameter
        when 21
          InvalidInput
        else
          Error
      end
      raise error_type, "#{status['message']} (#{val})"
    end
  end

  class Timeout < Error
  end

  class InvalidParameter < Error
  end

  class InvalidInput < Error
  end
end
