class MainQuery
    
  def get_station_name
    puts "Введите название станции (не менее 4-х символов)"
    gets.chomp.to_s
  end
    
  def get_train_num
    puts "Введите название поезда. Формат:
    три буквы или цифры в начале, дифис'-'(необязаельно), две буквы или цифры в конце"
    gets.chomp.to_s
  end
    
  def get_train_type
    puts "Введите тип поезда : 1 для 'Пассажирский', 2 для 'Грузовой'"
    gets.to_i
  end
  
  def get_cargo_num
    puts "Введите номер вагона. Формат:
    две буквы  в начале, дифис'-'(необязаельно), 1 цифра в конце"
    gets.chomp.to_s
  end
  
  def get_cargo_type
    puts "Введите тип вагона : 1 для 'Пассажирский', 2 для 'Грузовой'"
    gets.to_i
  end
  
  def get_cargo_cap
    puts "Укажите вместимость вагона"
    gets.to_i
  end
    
  def get_station_index(stations)
    puts "Выберете станцию из списка"
    stations.each.with_index(1) do |station, index| 
      puts "Станция #{station.station_name} || порядковый номер #{index}"
    end
    gets.chomp.to_i - 1
  end
    
  def get_station_index_1(stations)
    puts "Введите начальную станцию"
    stations.each.with_index(1) do |station, index| 
      puts "Станция #{station.station_name} || порядковый номер #{index}"
    end
    gets.chomp.to_i - 1
  end
    
        
  def get_station_index_2(stations)
    puts "Введите конечную станцию"
    stations.each.with_index(1) do |station, index| 
      puts "Станция #{station.station_name} || порядковый номер #{index}"
    end
    gets.chomp.to_i - 1
  end
    
  def get_route_index(routes)
    puts "Выберете маршрут из списка"
    routes.each.with_index(1) do |route, index| 
      puts "станции, номер маршрута #{index} #{route.show_stations}"
    end
    gets.chomp.to_i - 1
  end
    
  def get_train(trains)
    puts "Выберете поезд из списка"
    trains.each.with_index(1) do |train, index| 
      puts "#{index} | номер поезда #{train.train_number}  || тип -> #{train.train_type}"
    end
    gets.chomp.to_i - 1
  end
  
  def get_car(wagons)
    puts "Выберете поезд из списка"
    wagons.each.with_index(1) do |wagon, index| 
      puts "#{index} | номер вагона #{wagon.car_num}  || тип -> #{wagon.type}"
    end
    gets.chomp.to_i - 1
  end
  
  def object_error
    puts "Ошибка, объект еще не создан"
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
    
  def main_menu
    puts "Введите 1, если хотите создать станцию, маршрут, поезд, вагон"
    puts "Введите 2, если произвести операции с созданными обьектами"
    puts "Введите 3, если хотите получить данные об обьекте"
    puts "Введите 0, Выход"
    gets.to_i
  end        
        
  def create_menu
    puts "Введите 1, чтобы создать станцию"
    puts "Введите 2, чтобы создать маршрут"
    puts "Введите 3, чтобы создать поезд"
    puts "Введите 4, чтобы создать вагон"
    puts "Назад 0"
    gets.to_i
  end
    
  def object_operations
    puts "Введите 1, добавить станцию к маршруту"
    puts "Введите 2, удалить станцию из маршрута"
    puts "Введите 3, назначит маршрут поезду"
    puts "Введите 4, прицепить вагон поезду"
    puts "Введите 5, отцепить вагон поезду"
    puts "Введите 6, переместить поезд вперёд на станцию"
    puts "Введите 7, переместить поезд назад на станцию"
    puts "Введите 8, занять пространство в вагоне"
    puts "Назад 0"
    gets.to_i
  end

  def show_info
    puts "Введите 1, чтобы посмотреть список всех станций"
    puts "Введите 2, чтобы посмотреть список всех поездов на определённой станции"
    puts "Введите 3, чтобы посмотреть список всех созданных поездов"
    puts "Введите 4, чтобы посмотреть список всех созданных вагонов"
    puts "Назад 0"
    gets.to_i
  end
  
  def train_created(train_num)
    puts "Поезд с номером #{train_num} успешно создан!"
  end
  
  def station_created(station)
    puts "Станция с названием #{station} успешно создана!"
  end
    
end