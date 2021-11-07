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
      TickerCik.find_or_create_by!(cik: cik) do |ticker_cik|
        ticker_cik.tickers << ticker unless ticker_ciks.include?(ticker)
      end
    end
  end
end
