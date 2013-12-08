require 'forwardable'
module GeoNamesAPI
  class ListEndpoint < Base
    def self.endpoint_returns_list?
      true
    end

    def next_page
      self.class.where(request_params.merge(
        startRow: request_params[:startRow].to_i + size
      ))
    end

    # Pages are 0-indexed.
    def to_page(page_idx)
      self.class.where(request_params.merge(
        startRow: (request_params[:maxRows] || size).to_i * page_idx
      ))
    end
  end
end
