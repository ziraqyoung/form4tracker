module Sec
  class Filing
    extend Sec::Client

    def self.recent(count: 10)
      response = request(
        http_method: :get,
        endpoint: 'cgi-bin/browse-edgar',
        params: {
          action: 'getcurrent',
          type: 4.to_s,
          output: 'atom',
          count:,
          owner: 'include'
        }
      )

      entries = parse_xml_response(response.body)

      entries.map do |entry|
        Sec::FilingDetails.new(
          cik: entry[:title].match(/\((\w{10})\)/)[1],
          file_id: entry[:id].split('=').last,
          term: entry[:category][:term],
          title: entry[:title],
          summary: entry[:summary],
          date: DateTime.parse(entry[:updated]),
          link: entry[:link][:href].gsub('-index.htm', '.txt'),
        )
      end
    end
  end
end
