class AlphavantageService
  def initialize(params)
    @ticker = params[:ticker]
  end

  def call
    date_and_close_pairs = fetch_prices
  rescue Alphavantage::Error => e
    OpenStruct.new({ success?: false, error: e })
  else
    OpenStruct.new({ success?: true, payload: Hash[date_and_close_pairs] })
  end

  private

    def client
      @client ||= Alphavantage::Client.new(
        key: Rails.application.credentials.dig(:alphavantage, :key)
      )
    end

    def fetch_prices
      client.stock(symbol: @ticker)
        .timeseries(adjusted: true, outputsize: 'full')
        .output["Time Series (Daily)"]
        .map { |k, v| [k, v["5. adjusted close"]] }
    end
end
