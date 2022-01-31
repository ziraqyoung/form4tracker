module Sec
  module Client
    API_ENDPOINT = 'https://www.sec.gov'.freeze

    def client
      @client ||= Faraday.new(API_ENDPOINT) do |client|
        client.request :url_encoded
        client.adapter Faraday.default_adapter
        client.headers = {
          'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36',
          'Connection' => 'keep-alive',
          'Accept' => '*/*',
        }
      end
    end

    def request(http_method:, endpoint:, params: {})
      client.public_send(http_method, endpoint, params)
    end

    def parse_xml_response(response)
      Hash.from_xml(response).deep_symbolize_keys.dig(:feed, :entry)
    end
  end
end
