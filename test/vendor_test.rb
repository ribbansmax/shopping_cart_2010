require './test/test_helper'

class VendorTest < Minitest::Test
  def test_it_exists_and_has_attributes
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal "Rocky Mountain Fresh", vendor.name
    assert_equal ({}), vendor.inventory
  end

  def test_it_can_add_and_check_stock
    vendor = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})

    assert_equal 0, vendor.check_stock(item1)

    vendor.stock(item1, 30)

    expected = {item1 => 30}

    assert_equal expected, vendor.inventory
    assert_equal 30, vendor.check_stock(item1)
  end
end