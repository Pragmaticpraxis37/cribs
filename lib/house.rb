class House
  attr_reader :price,
              :address,
              :rooms

  def initialize(price, address)
    @price = price
    @address = address
    @rooms = []
    @total = 0
  end

  def add_room(room)
    @rooms << room
  end

  def above_market_average?
    @price.delete("$").to_i > 500000
  end

  def rooms_from_category(room_category)
    rooms.find_all do |room|
      room.category == room_category
    end
  end

  def area
    rooms.each do |room|
      @total += room.length * room.width.to_i
    end
    @total
  end

  def details
    {"price" => price.delete("$").to_i, "address" => address}
  end

  def price_per_square_foot
    price = @price.delete("$").to_f / @total
    price = price.round(2)
  end

  def rooms_by_category
    by_category = Hash.new {|h, k| h[k] = []}

    @rooms.each do |room|
      by_category[room.category] << room
    end
    by_category
  end
end
