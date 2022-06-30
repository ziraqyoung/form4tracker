module StockPrices
  class Client
    API_ENDPOINT = 'https://financialmodelingprep.com'.freeze

    def initialize(api_key:)
      @api_key = api_key
    end

    def for_ticker(symbol)
      request(
        http_method: :get,
        endpoint: "api/v3/historical-price-full/#{symbol.upcase}"
      )
    end

    def for_tickers(*symbols)
      request(
        http_method: :get,
        endpoint: "api/v3/historical-price-full/#{symbols.join(',')}"
      )
    end

    private

      def client
        @_client ||= Faraday.new(API_ENDPOINT) do |client|
          client.request :url_encoded
          client.adapter Faraday.default_adapter
          client.params['apikey'] = @api_key
        end
      end

      def request(http_method:, endpoint:, params: {})
        response = client.public_send(http_method, endpoint, params)
        Oj.load(response.body)
      end
  end
end
