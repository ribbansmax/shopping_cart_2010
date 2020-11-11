require './test/test_helper'

class MarketTest < Minitest::Test
  def test_it_exists_and_has_attributes
    market = Market.new("South Pearl Street Farmers Market")

    assert_equal "South Pearl Street Farmers Market", market.name
    assert_equal [], market.vendors
  end

  def test_it_can_add_vendors
    market = Market.new("South Pearl Street Farmers Market")
    vendor = Vendor.new("Rocky Mountain Fresh")
    market.add_vendor(vendor)

    assert_equal [vendor], market.vendors
  end
end