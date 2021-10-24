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
