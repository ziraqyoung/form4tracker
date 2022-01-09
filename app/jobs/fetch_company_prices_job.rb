class FetchCompanyPricesJob < ApplicationJob
  queue_as :default

  def perform(company_id)
    company = Company.find(company_id)

    client = StockPrices::Client.new(
      api_key: Rails.application.credentials.dig(:financialmodelingprep, :api_key)
    )

    prices = if client.for_ticker(company.ticker) && client.for_ticker(company.ticker)['historical'].present?
               Hash[
                 client.for_ticker(company.ticker)['historical']
                 .map do |entry|
                   next if entry['date'].blank? || entry.blank?
                   [entry['date'], entry['adjClose'] ]
                 end
               ]

             end

    company.update!(prices: prices) if prices.present?
  end
end
