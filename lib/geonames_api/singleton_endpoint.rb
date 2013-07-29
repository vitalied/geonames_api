module GeoNamesAPI
  class SingletonEndpoint < Base
    def self.endpoint_returns_list?
      false
    end
  end
end
