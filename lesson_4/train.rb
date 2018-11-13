class Train
    attr_reader :speed, :train_type, :train_number
    def initialize(train_number, train_type == cargo || :passenger)
      @train_number = train_number
      @train_type = train_type
      @speed = 0
      @route = nil
      @station_pos = 0
    end

    def stop
      @speed = 0
    end

    def accelerate(added_speed)
      @speed += added_speed
    end


    def add_route(route)
      @route = route
      @route.stations_list[0].check_in(self)
    end

    def current_station
      @route.stations_list[@station_pos]
    end

    def go_next_station
      return unless next_station
      current_station.check_out(self)
      @station_pos += 1
      current_station.check_in(self)
    end

    def go_prev_station
      return unless prev_station
      current_station.check_out(self)
      @station_pos -= 1
      current_station.check_in(self)
    end

    private

    def next_station
      @route.stations_list[@station_pos + 1]
    end

    def prev_station
      @route.stations_list[@station_pos - 1] unless @station_pos.zero?
    end

end
