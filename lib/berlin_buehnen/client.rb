module BerlinBuehnen
  class Client
    include HTTMultiParty
    USER_AGENT = "ASK HELMUT BerlinBuehnen API Wrapper #{VERSION}"
    API_USERNAME_PARAM_NAME = "username"
    API_KEY_PARAM_NAME = "api_key"
    API_VERSION = "v1"
    API_FORMAT = "json"
    DEFAULT_OPTIONS = {
      site: "www.berlin-buehnen.de",
      language: "de"
    }

    attr_accessor :options
    headers({"User-Agent" => USER_AGENT})

    def initialize(options = {})
      store_options(options)
      raise ArgumentError, "An api key must be present" if api_key.nil?
      raise ArgumentError, "An api username must be present" if api_username.nil?
    end

    def get(path, query={}, options={})
      handle_response {
        self.class.get(*construct_query_arguments(path, options.merge(:query => query)))
      }
    end

    def head(path, query={}, options={})
      handle_response {
        self.class.head(*construct_query_arguments(path, options.merge(:query => query)))
      }
    end

    # accessors for options
    def api_username
      @options[:username]
    end

    def api_key
      @options[:api_key]
    end

    def site
      @options[:site]
    end
    alias host site

    def api_host
      host
    end

    def api_language
      @options[:language]
    end

    def api_url
      [api_host, api_language, "api", API_VERSION].join("/")
    end

    private

    def handle_response(refreshing_enabled=true, &block)
      response = block.call
      return unless response

      raise ResponseError.new(response) unless response.success?

      BerlinBuehnen::Response.new(response)
    end

    def store_options(options={})
      @options ||= DEFAULT_OPTIONS.dup
      @options.merge!(options)
    end

    def construct_query_arguments(path_or_uri, options={}, body_or_query=:query)
      uri = URI.parse(path_or_uri)
      path = uri.path
      scheme = "http"
      options = options.dup
      options[body_or_query] ||= {}
      options[body_or_query][:format] = API_FORMAT
      options[body_or_query][API_USERNAME_PARAM_NAME.to_sym] = api_username
      options[body_or_query][API_KEY_PARAM_NAME.to_sym] = api_key

      [
        "#{scheme}://#{api_url}#{path}#{uri.query ? "?#{uri.query}" : ""}",
        options
      ]
    end
  end
end
