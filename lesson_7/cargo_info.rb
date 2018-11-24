module CargoInfo
  def cargo_info
    each_cargo do |car|
      if car.is_a? PassengerCarriage
        puts "Вагон № #{car.car_num}, тип: #{car.type}, мест свободно: #{car.space_available}, мест занято: #{car.space_taken}"
      else
        puts "Вагон № #{car.car_num}, тип: #{car.type}, кол-во свободного объема: #{car.space_available}, кол-во занятого объема: #{car.space_taken}"
      end
    end
  end
end
