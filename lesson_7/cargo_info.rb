module CargoInfo
  def cargo_info
    each_cargo do |car|
      if car.is_a? PassengerCarriage
        puts "Вагон № #{car.car_num}, тип: #{car.type}, мест свободно: #{car.seats_available}, мест занято: #{car.taken_seats}"
      else
        puts "Вагон № #{car.car_num}, тип: #{car.type}, кол-во свободного объема: #{car.space_available}, кол-во занятого объема: #{car.taken_space}"
      end
    end
  end
end
