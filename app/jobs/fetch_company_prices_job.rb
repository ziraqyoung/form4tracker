class FetchCompanyPricesJob < ApplicationJob
  queue_as :default

  def perform(company_id)
    company = Company.find(company_id)

    company_prices = AlphavantageService.new({ticker: company.ticker}).call

    if company_prices && company_prices.success?
      company.prices = company_prices.payload
      company.save!
    end
  end
end
