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

  def test_it_can_return_vendors_that_sell_item
    market = Market.new("South Pearl Street Farmers Market")
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    vendor1.stock(item1, 30)
    expected = [vendor1]

    assert_equal expected, market.vendors_that_sell(item1)
  end

  def test_it_can_return_sorted_item_list
    market = Market.new("South Pearl Street Farmers Market")
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    vendor1.stock(item1, 30)
    vendor2.stock(item1, 30)
    vendor1.stock(item2, 30)
    expected = ["Peach", "Tomato"]

    assert_equal expected, market.sorted_items_list
  end

  def test_it_can_return_total_inventory
    market = Market.new("South Pearl Street Farmers Market")
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    vendor1.stock(item1, 30)
    vendor2.stock(item1, 30)
    vendor1.stock(item2, 30)
    expected = {
      item1 => {
        quantity: 60,
        vendors: [vendor1, vendor2]
      },
      item2 => {
        quantity: 30,
        vendors: [vendor1]
      }
    }

    assert_equal expected, market.total_inventory
  end

  def test_it_can_tell_overstocked_items
    market = Market.new("South Pearl Street Farmers Market")
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    vendor1.stock(item1, 30)
    vendor2.stock(item1, 30)
    vendor1.stock(item2, 30)
    expected = [item1]

    assert_equal expected, market.overstocked_items
  end

  def test_it_can_check_to_sell_item
    market = Market.new("South Pearl Street Farmers Market")
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    vendor1.stock(item1, 30)
    vendor2.stock(item1, 30)
    vendor1.stock(item2, 30)

    assert market.check_sale(item1, 40)
    assert_equal false, market.check_sale(item1, 70)
  end

  def test_it_can_sell_item
    market = Market.new("South Pearl Street Farmers Market")
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    vendor1.stock(item1, 30)
    vendor2.stock(item1, 30)
    vendor1.stock(item2, 30)

    market.sell(item1, 40)
    assert_equal 0, vendor1.check_stock(item1)
    assert_equal 20, vendor2.check_stock(item1)
  end

  def test_it_can_make_all_items
    market = Market.new("South Pearl Street Farmers Market")
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    vendor1.stock(item1, 30)
    vendor2.stock(item1, 30)
    vendor1.stock(item2, 30)

    assert_equal [item1, item2], market.all_items
  end

  def test_it_can_tell_date
    Date.stubs(:today).returns(Date.parse("19251012"))
    market = Market.new("South Pearl Street Farmers Market")

    # bonus points if you can name the world famous juggler born on this day
    # check item_test.rb for a hint
    assert_equal "12/10/1925", market.date
  end
end