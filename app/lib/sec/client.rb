module Sec
  class Client
    API_ENDPOINT = 'https://www.sec.gov'.freeze

    def initialize()
    end

    def filings_for(symbol)
      response = request(
        http_method: :get,
        endpoint: "cgi-bin/browse-edgar",
        params: { 
          "CIK": symbol.to_s,
          output: 'atom'
        }
      )

      parse_xml_response(response.body)
    end

    def recent(count: 10)
      response = request(
        http_method: :get,
        endpoint: "cgi-bin/browse-edgar",
        params: {
          action: 'getcurrent',
          type: 4.to_s,
          output: 'atom',
          count: count,
          owner: 'include'
        }
      )

      entries = parse_xml_response(response.body)

      entries.map do |entry|
        Sec::Filing.new(
          cik: entry[:title].match(/\((\w{10})\)/)[1],
          file_id: entry[:id].split('=').last,
          term: entry[:category][:term],
          title: entry[:title],
          summary: entry[:summary],
          date: DateTime.parse(entry[:updated]),
          link: entry[:link][:href].gsub('-index.htm', '.txt')
        )
      end
    end

    private

      def client
        @_client ||= Faraday.new(API_ENDPOINT) do |client|
          client.request :url_encoded
          client.adapter Faraday.default_adapter
          client.headers = {
            'User-Agent' => 'PostmanRuntime/7.28.4',
            'Connection' => 'keep-alive',
            # 'Accept-Encoding' => 'gzip, deflate, br',
            'Accept' => '*/*'
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
