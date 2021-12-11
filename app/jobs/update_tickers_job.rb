class UpdateTickersJob < ApplicationJob
  queue_as :default

  def perform()
    # fetch ticker/cik combination from https://www.sec.gov/include/ticker.txt
    mappings = HTTParty
      .get("https://www.sec.gov/include/ticker.txt")
      .body # get response body as a string
      .split("\n")
      .map { |pair| pair.split("\t") } # ["aapl", "320193"]

    mappings.each do |(ticker, cik)|
      ticker_cik = TickerCik.find_by(cik: cik)

      if ticker_cik
        unless ticker_cik.tickers.include?(ticker)
          ticker_cik.tickers << ticker
          ticker_cik.save!
        end
      else
        TickerCik.create!(cik: cik, tickers: [ticker])
      end
    end
  end
end
