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
require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  setup do
    @beam = companies(:beam_global)
  end

  test 'should be valid' do
    assert @beam.valid?
  end

  test ':cik must be present' do
    @beam.cik = nil
    assert @beam.invalid?
  end

  test ':cik must be unique' do
    @beam.save!
    @dup_beam = @beam.dup

    assert_no_difference 'Company.count' do
      @dup_beam.save
    end

    assert_equal @dup_beam.errors.count, 1 
  end
end
