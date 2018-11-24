class Train
  include CompanyName
  include InstanceCounter
  include Validator
  include CargoInfo

  TRAIN_REGEXP = /(^[a-zA-Z0-9]{3}-?[a-zA-Z0-9]{2}$)|(^[а-яА-Я0-9]{3}-?[а-яА-Я0-9]{2}$)/

  attr_reader :speed, :train_number, :cargoes, :train_type, :route

  @@trains_all = {}

  def initialize(train_number, train_type)
    @train_number = train_number.upcase
    @train_type = train_type
    @speed = 0
    @station_pos = 0
    @cargoes = []
    validate!
    trains_list
    register_instance
  end

  def self.find(train_number)
    @@trains_all[train_number]
  end


  def curren_speed
    @speed
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

  def add_cargo(cargo)
    return if is_move?
    if self.train_type == :passenger_train && cargo.is_a?(PassengerCarriage) ||
      self.train_type == :cargo_train && cargo.is_a?(CargoCarriage)
      self.cargoes << cargo
    else
      return puts "Тип поезда и вагона не совпадают!"
    end
  end

  def remove_cargo
    return if is_move?
    self.cargoes.pop
  end

  def each_cargo
    @cargoes.each { |car| yield(car) }
  end

  protected
  #Эти методы не используются напрямую, доступны подклассам
  def is_move?
    @speed > 0
  end

  def current_station
    route.stations_list[@station_pos]
  end

  def next_station
    route.stations_list[@station_pos + 1]
  end

  def prev_station
    route.stations_list[@station_pos - 1] unless @station_pos.zero?
  end

  def trains_list
    @@trains_all[train_number] = self
  end

  def validate!
    raise "Неверный формат номера" if train_number !~ TRAIN_REGEXP
  end


end
