# == Schema Information
#
# Table name: ticker_ciks
#
#  id         :bigint           not null, primary key
#  cik        :string           not null
#  tickers    :string           default([]), is an Array
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ticker_ciks_on_cik      (cik) UNIQUE
#  index_ticker_ciks_on_tickers  (tickers) USING gin
#
class TickerCik < ApplicationRecord
  validates :cik, uniqueness: true
end
