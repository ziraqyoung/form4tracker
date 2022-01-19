module Sec
  class Filing
    COLUMNS = [:cik, :title, :summary, :link, :term, :date, :file_id]

    attr_accessor(*COLUMNS)

    def initialize(filing)
      COLUMNS.each do |column|
        instance_variable_set("@#{column}", filing[column])
      end
    end
  end
end
