require 'date'
class Market
  attr_reader :name, :vendors, :date
  def initialize(name)
    @name = name
    @vendors = []
    @date = todays_date
  end

  def todays_date
    Date.today.strftime("%d/%m/%Y")
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    vendors.select do |vendor|
      vendor.check_stock(item) > 0
    end
  end

  def sorted_items_list
    vendors.flat_map do |vendor|
      vendor.item_names
    end.uniq.sort
  end

  def all_items
    vendors.flat_map do |vendor|
      vendor.inventory.keys
    end.uniq
  end

  def item_breakdown(item)
    vendors = vendors_that_sell(item)
    quantity = vendors.sum do |vendor|
      vendor.check_stock(item)
    end  
    { quantity: quantity, vendors: vendors}
  end

  def total_inventory
    total = {}
    all_items.each do |item|
      total[item] = item_breakdown(item)
    end
    total
  end

  def overstocked_items
    overstocked = []
    total_inventory.each_pair do |item, breakdown|
      if breakdown[:quantity] > 50 && breakdown[:vendors].length > 1
        overstocked << item
      end
    end
    overstocked
  end

  def check_sale(item, amount)
    total_inventory[item][:quantity] >= amount
  end

  def increment_sales_from(vendor, item, amount)
    while amount > 0 && vendor.check_stock(item) > 0 do
      amount -= 1
      vendor.stock(item, -1)
    end
    amount
  end

  def sell(item, amount)
    if check_sale(item, amount)
      total_inventory[item][:vendors].each do |vendor|
        amount = increment_sales_from(vendor, item, amount)
      end
    else
      false
    end
  end
end