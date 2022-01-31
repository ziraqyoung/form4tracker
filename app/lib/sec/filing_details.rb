module Sec
  class FilingDetails
    include Sec::Client

    COLUMNS = %i[cik title summary link term date file_id content].freeze

    attr_reader(*COLUMNS)

    def initialize(filing)
      COLUMNS.each do |column|
        instance_variable_set("@#{column}", filing[column])
      end
    end

    def content
      request(
        http_method: :get,
        endpoint: (link.remove('https://www.sec.gov/'))
      )
    end
  end
end
