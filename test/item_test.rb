require './test/test_helper'

class ItemTest < Minitest::Test
  def test_it_exists_and_has_attributes
    item1 = Item.new({name: "Peach", price: "$0.75"})

    assert_equal "Peach", item1.name
    assert_equal 0.75, item1.price
  end
end