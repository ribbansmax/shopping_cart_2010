require './test/test_helper'

class ItemTest < Minitest::Test
  def test_it_exists_and_has_attributes
    item1 = Item.new({name: "Peach", price: "$0.75"})

    assert_equal "Peach", item1.name
    assert_equal 0.75, item1.price
  end

  def test_it_can_be_juggled_by_the_fastest_female_juggler_of_all_time
    item1 = Item.new({name: "Peach", price: "$0.75"})

    assert item1
  end
end