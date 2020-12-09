require 'minitest/autorun'
require 'minitest/pride'
require './lib/room'
require './lib/house'

class HouseTest < Minitest::Test
  def test_it_exists
    house = House.new("$400000", "123 sugar lane")
    assert_instance_of House, house
  end

  def test_price_can_be_displayed
    house = House.new("$400000", "123 sugar lane")
    assert_equal "$400000", house.price
  end

  def test_address_can_be_displayed
    house = House.new("$400000", "123 sugar lane")
    assert_equal "123 sugar lane", house.address
  end

  def test_rooms_in_house_starts_empty
    house = House.new("$400000", "123 sugar lane")
    assert_equal [], house.rooms
  end

  def test_add_rooms_can_accept_rooms
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')

    house.add_room(room_1)
    house.add_room(room_2)

    rooms = [room_1, room_2]

    assert_equal rooms, house.rooms
  end

  def test_above_market_average_returns_true_or_false
    house_1 = House.new("$400000", "123 sugar lane")
    house_2 = House.new("$500000", "125 sugar lane")
    house_3 = House.new("$550000", "125 sugar lane")

    assert_equal false, house_1.above_market_average?
    assert_equal false, house_2.above_market_average?
    assert_equal true, house_3.above_market_average?
  end

  def test_rooms_from_category_can_select_different_types_of_rooms
    house = House.new("$400000", "123 sugar lane")

    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    bedrooms = [room_1, room_2]
    basement = [room_4]

    assert_equal bedrooms, house.rooms_from_category(:bedroom)
    assert_equal basement, house.rooms_from_category(:basement)
  end

  def test_area_can_calculate_for_entire_house
    house = House.new("$400000", "123 sugar lane")

    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    assert_equal 1900, house.area
  end

  def test_details_returns_price_and_address_information
    house = House.new("$400000", "123 sugar lane")

    details = {"price" => 400000, "address" => "123 sugar lane"}
    assert_equal details, house.details
  end

  def test_price_per_square_foot_gives_price
    house = House.new("$400000", "123 sugar lane")

    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    house.area
    assert_equal 210.53, house.price_per_square_foot
  end

  def test_rooms_by_category_gives_hash_information
    house = House.new("$400000", "123 sugar lane")

    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    by_category = {:bedroom => [room_1, room_2], :living_room => [room_3], :basement => [room_4]}

    assert_equal by_category, house.rooms_by_category
  end

end
