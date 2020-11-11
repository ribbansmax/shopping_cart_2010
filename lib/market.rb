class Market
  attr_reader :name, :vendors
  def initialize(name)
    @name = name
    @vendors = []
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

  def total_inventory
    total = {}
    all_items = vendors.flat_map do |vendor|
      vendor.inventory.keys
    end.uniq
    all_items.each do |item|
      vendors = vendors_that_sell(item)
      quantity = vendors.sum do |vendor|
        vendor.check_stock(item)
      end  
      total[item] = { quantity: quantity, vendors: vendors}
    end
    total
  end
end