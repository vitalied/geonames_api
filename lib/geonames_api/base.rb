require 'cgi'

module GeoNamesAPI
  class Base < Entity

    def self.find(*names_or_params)
      result = where(name_params(names_or_params))
      if result
        endpoint_returns_list? ? result.first : result
      end
    end

    def self.all(*names_or_params)
      result = where(name_params(names_or_params))
      if result
        endpoint_returns_list? ? result : [result]
      end
    end

    def self.where(params={})
      retries_remaining = GeoNamesAPI.retries
      url = url(params)
      begin
        response = make_request(url)
        unless response.empty?
          parse_response(response, params)
        end
      rescue Timeout => e
        if retries_remaining > 0
          retries_remaining -= 1
          puts "retrying!"
          sleep rand * GeoNamesAPI.max_sleep_time_between_retries
          retry
        else
          raise e
        end
      end
    end

    def self.make_request(url)
      JSON.load(open(url).read)
    end

    private_class_method :make_request

    KEYS = %w(streetSegment geonames)

    def self.parse_response(response, request_params)
      GeoNamesAPI.logger.info "GEONAMES RESPONSE (#{Time.now}): #{response}" if GeoNamesAPI.logger
      if (status = response['status'])
        raise Error.from_status(status)
      end
      new(response, request_params)
    end

    private_class_method :parse_response

    def self.url(params={})
      endpoint = GeoNamesAPI.url + self::METHOD + params_to_url(GeoNamesAPI.params.merge(params))
      GeoNamesAPI.logger.info "GEONAMES REQUEST (#{Time.now}): #{endpoint}" if GeoNamesAPI.logger
      endpoint
    end

    private_class_method :url

    def self.name_params(names)
      return names.first if names.first.is_a? Hash
      params, n = {}, 0
      if names.any?
        [self::FIND_PARAMS].flatten.each { |i| params[i] = names[n]; n+= 1 }
      end
      params.delete_if { |k, v| v.blank? }
    end

    private_class_method :name_params

    def self.params_to_url(params={})
      esc_params = params.map do |key, value|
        "#{esc(key)}=#{esc(value)}"
      end
      "?#{esc_params.join('&')}"
    end

    private_class_method :params_to_url

    def self.esc(str)
      CGI::escape(str.to_s)
    end

    private_class_method :esc
  end
end
