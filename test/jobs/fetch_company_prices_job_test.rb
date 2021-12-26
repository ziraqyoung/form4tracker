require "test_helper"

class FetchCompanyPricesJobTest < ActiveJob::TestCase
  setup do
    @beam_global = companies(:beam_global)
    VCR.insert_cassette(name)
  end

  teardown do
    VCR.eject_cassette
  end

  test "prefills company prices" do
    skip
    FetchCompanyPricesJob.perform_now(@beam_global.id)
    assert_not_empty @beam_global.reload.prices
  end
end
