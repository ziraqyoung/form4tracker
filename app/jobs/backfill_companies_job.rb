class BackfillCompaniesJob < ApplicationJob
  queue_as :default

  def perform
    [2021, 2022].each do |year|
      [1,2,3,4].each do |qtr|
        # https://www.sec.gov/Archives/edgar/full-index/2021/QTR4/ (year - 2021, qtr - 4)
        filings = HTTParty
          .get("https://www.sec.gov/Archives/edgar/full-index/#{year}/QTR#{qtr}/master.idx", {
            headers: {
              "User-Agent" => "PostmanRuntime/7.26.8",
              "Connection": "keep-alive",
              "Accept-Encoding": "gzip, deflate, br",
              "Accept": "*/*",
            },
          })
          .body
          .split("\n")

        # trim the header upto --------- (including it)
        header_index = filings.find_index { |r| r.starts_with?("-----------------") }

        # get an array or arrays i.e  [["98752", "TOROTEL INC"]],
        filings
          .drop(header_index + 1)
          .map { |f| f.split("|") }
          .select { |f| f[2] == "4" }
          .uniq { |element| element[0] }
          .map { |f| f.take(2) }
          .each do |(cik, name)|
            if (ticker = TickerCik.find_by(cik: cik))
              ticker_symbol = ticker.tickers.first
              c = Company.find_or_create_by!(cik: cik)
              c.update(name: name, ticker: ticker_symbol)
            end
          end
      end
    end
  end
end
