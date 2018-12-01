# frozen_string_literal: true

module CargoInfo
  def cargo_info
    each_cargo do |car|
      if car.is_a? PassengerCarriage
        puts "№ #{car.num}, тип: #{car.type},свободно: #{car.free_seats}," \
             "занято: #{car.taken_seats}"
      else
        puts "№ #{car.num}, тип: #{car.type},доступно: #{car.free_space}," \
             "кол-во занятого объема: #{car.taken_space}"
      end
    end
  end
end
