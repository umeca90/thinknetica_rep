class Train
    attr_reader :speed, :train_type, :train_number, :count_of_carriages
    #Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов,
    # эти данные указываются при создании экземпляра класса.
    def initialize(train_number, train_type, count_of_carriages)
      @train_number = train_number
      @train_type = train_type
      @count_of_carriages = count_of_carriages
      @speed = 0
      @route = nil
      @station_pos = 0
    end
    #Может возвращать текущую скорость
    def current_speed
      puts "Текущая скорость = #{self.speed}"
    end
    #Может тормозить (сбрасывать скорость до нуля)
    def stop
      @speed = 0
    end
   #Может набирать скорость
    def accelerate(added_speed)
      @speed += added_speed
      puts "Скорость увелечина на #{added_speed}"
    end
    #Может возвращать количество вагонов
    def current_carriages
      @count_of_carriages
    end
    #Может прицеплять
    def add_coach
      @speed == 0 ? @count_of_carriages += 1 : "сначало остановите поезд"
    end
    #Может отцеплять
    def remove_coach
      return if @count_of_carriages == 0
      @speed == 0 ? @count_of_carriages -= 1 : "сначало остановите поезд"
    end
    #Может принимать маршрут следования (объект класса Route)
    def add_route(route)
      @route = route
      @route.stations_list[0].check_in(self) #При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
    end
    #Возвращать текущую станцию
    def current_station
      @route.stations_list[@station_pos]
    end
    #Переммещаться на 1 станцию вперед
    def go_next_station
      return unless next_station
      current_station.check_out(self)
      @station_pos += 1
      current_station.check_in(self)
    end
    #Переммещаться на 1 станцию назад
    def go_prev_station
      return unless prev_station
      current_station.check_out(self)
      @station_pos -= 1
      current_station.check_in(self)
    end

    def next_station
      @route.stations_list[@station_pos + 1]
    end
    #Возвращать предыдущую станцию
    def prev_station
      @route.stations_list[@station_pos - 1] unless @station_pos.zero?
    end

end
