class Company < ApplicationRecord
  validates :cik, presence: true, uniqueness: true
end
