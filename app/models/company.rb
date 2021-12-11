# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  cik        :string           not null
#  name       :string
#  prices     :json
#  ticker     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_companies_on_cik  (cik) UNIQUE
#
class Company < ApplicationRecord
  validates :cik, presence: true, uniqueness: true
end
