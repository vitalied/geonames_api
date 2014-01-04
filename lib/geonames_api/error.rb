module GeoNamesAPI
  class Error < StandardError
    # See http://www.geonames.org/export/webservice-exception.html
    def self.from_status(status)
      error_code = status['value'].to_i
      error_class = for_error_code(error_code) || self
      raise error_class, "#{status['message']} (#{error_code})"
    end

    def self.for_error_code(error_code)
      @lookup ||= subclasses.reduce({}) do |h, subclass|
        subclass::ERROR_CODES.each { |ea| h[ea] = subclass }
        h
      end
      @lookup[error_code]
    end
  end

  class AuthorizationException < Error
    ERROR_CODES = [10]
  end
  class RecordDoesNotExist < Error
    ERROR_CODES = [11]
  end
  class Timeout < Error
    # 12 is "other error", but is normally "Cannot get a connection, pool error Timeout waiting for idle object"
    ERROR_CODES = [12, 13, 22]
  end
  class InvalidParameter < Error
    ERROR_CODES = [14]
  end
  class NoResultFound < Error
    ERROR_CODES = [15]
  end
  class DuplicateException < Error
    ERROR_CODES = [16]
  end
  class PostalCodeNotFound < Error
    ERROR_CODES = [17]
  end
  class DailyLimitExceeded < Error
    ERROR_CODES = [18]
  end
  class HourlyLimitExceeded < Error
    ERROR_CODES = [19]
  end
  class WeeklyLimitExceeded < Error
    ERROR_CODES = [20]
  end
  class ServiceNotImplemented < Error
    ERROR_CODES = [23]
  end
end
