# frozen_string_literal: true

module QueryMethods
  def ask_station_name
    puts "Введите название станции (не менее 4-х символов)"
    gets.chomp.to_s.capitalize
  end

  def ask_train_num
    puts "Введите название поезда. Формат:
    три буквы или цифры в начале, дифис'-'(необяз), две буквы или цифры в конце"
    gets.chomp.to_s
  end

  def ask_train_type
    puts "Введите тип поезда : 1 для 'Пассажирский', 2 для 'Грузовой'"
    gets.to_i
  end

  def ask_cargo_type
    puts "Введите тип вагона : 1 для 'Пассажирский', 2 для 'Грузовой'"
    gets.to_i
  end

  def ask_cargo_cap
    puts "Укажите вместимость вагона"
    gets.to_i
  end

  def ask_station
    puts "Введите название станции (из списка)"
    Station.all.each_key { |key| puts "Станция #{key}" }
    name = gets.chomp.to_s
    Station.find_by_name(name)
  end

  def ask_route
    puts "Выберете маршрут из списка"
    Route.routes.each.with_index(1) do |route, index|
      puts "станции, номер маршрута #{index} #{route.show_stations}"
    end
    index = gets.chomp.to_i - 1
    Route.routes[index]
  end

  def ask_train
    puts "Введите номер поезда (из списка)"
    Train.trains_all.each { |k, v| puts "№ #{k}, тип -> #{v.type}" }
    train = gets.chomp.to_s
    Train.find(train)
  end

  def ask_car
    puts "Выберете поезд из списка"
    Carriage.cars.each.with_index(1) do |c, i|
      puts "#{i} | номер вагона #{c.num}  || тип -> #{c.type}"
    end
    car = gets.chomp.to_i - 1
    Carriage.cars[car]
  end

  def train_created(train_num)
    puts "Поезд с номером #{train_num} успешно создан!"
  end

  def station_created(station)
    puts "Станция с названием #{station} успешно создана!"
  end

  def object_error
    puts "Ошибка, недостаточно обьектов"
  end

  def simple_error
    puts "Ошибка ввода"
  end

  def station_error
    puts "Ошибка ввода станции"
  end

  def train_error
    puts "Ошибка ввода поезда"
  end

  def route_error
    puts "Ошибка ввода маршрута"
  end
end
