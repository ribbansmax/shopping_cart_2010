require './test/test_helper'

class MarketTest < Minitest::Test
  def test_it_exists_and_has_attributes
    market = Market.new("South Pearl Street Farmers Market")

    assert_equal "South Pearl Street Farmers Market", market.name
    assert_equal [], market.vendors
  end

  def test_it_can_add_vendors
    market = Market.new("South Pearl Street Farmers Market")
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    market.add_vendor(vendor1)

    assert_equal [vendor1], market.vendors
  end

  def test_it_can_return_vendor_names
    market = Market.new("South Pearl Street Farmers Market")
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    expected = ["Rocky Mountain Fresh", "Ba-Nom-a-Nom"]

    assert_equal expected, market.vendor_names
  end
end