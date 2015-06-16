module BerlinBuehnen
  class Response
    attr_reader :json_response

    def self.create(response)
      json_response = JSON.parse(response.body)

      json_response.has_key?("meta") ? ListResponse.new(json_response) : new(json_response)
    end

    def initialize(json_response)
      @json_response = json_response
    end

    def data
      @data ||= @json_response
    end

  end
end
