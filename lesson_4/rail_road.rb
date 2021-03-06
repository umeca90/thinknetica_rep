require_relative "company_name.rb"
require_relative("instance_counter")
require_relative "train.rb"
require_relative "station.rb"
require_relative "route.rb"
require_relative "carriage.rb"
require_relative "passenger_train.rb"
require_relative "cargo_train.rb"
require_relative "passenger_carriage.rb"
require_relative "cargo_carriage.rb"
require_relative "main_query.rb"


class RailRoad
  attr_reader :stations, :trains
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
    @query = MainQuery.new
  end

  def main_menu_list
    loop do
      input = @query.main_menu
      case input
      when 1
        create_list
      when 2
        operations_list
      when 3
        info_list
      when 0
        break
      end
    end
  end

  private # Эти методы используются только в пользовательском меню.

  def create_list
    loop do
      input = @query.create_menu
      case input
      when 1
       create_station
      when 2
       create_route
      when 3
       create_train
      when 0
       break
      end
    end
  end

  def operations_list
    loop do
      input = @query.object_operations
      case input
      when 1
        add_st_to_route
      when 2
        del_station_from_route
      when 3
        assigne_route
      when 4
        assigne_cargo
      when 5
        del_cargo
      when 6
      move_next_st
      when 7
        move_prev_st
      when 0
        break
      end
    end
  end

  def info_list
   loop do
      input = @query.show_info
      case input
      when 1
        show_all_stations
      when 2
        show_station_trains
      when 0
        break
      end
    end
  end

  def create_station
    station =  @query.get_station_name
    @stations << Station.new(station)
    puts "Создана станция #{@stations.last.station_name}"
  end

  def create_train
    train_num = @query.get_train_num
    train_type = @query.get_train_type
      if train_type == 1
        @trains <<  PassengerTrain.new(train_num)
        puts "Создан Пассажирский поезд с номером #{train_num}"
      elsif train_type == 2
        @trains << CargoTrain.new(train_num)
        puts "Создан Грузовой поезд с номером #{train_num}"
      end
  end

  def create_route
    if @stations.count > 1
    start = @query.get_station_index_1(@stations)
    return @query.station_error if station_in_range?(start)
    end_st = @query.get_station_index_2(@stations)
    return @query.station_error if station_in_range?(end_st)
    route =  Route.new(@stations[start],@stations[end_st])
    @routes << route
    puts "Создан маршрут #{route.stations_list.first.station_name} --> #{route.stations_list.last.station_name}"
    else
        puts "Недостаточно станций для создания маршрута"
    end
  end

  def add_st_to_route
    if @routes.size < 1
      puts "Саначала создайте маршруты"
    else
      route = @query.get_route_index(@routes)
      return @query.route_error if route_in_range?(route)
      station = @query.get_station_index(@stations)
      return @query.station_error if station_in_range?(station)
      @routes[route].add_station(@stations[station])
    end
  end

  def del_station_from_route
    if @routes.size < 1
      puts "Саначала создайте маршруты"
    else
      route = @query.get_route_index(@routes)
      return @query.route_error if route_in_range?(route)
      station = @query.get_station_index(@stations)
      return @query.station_error if station_in_range?(station)
      @routes[route].stations_list.delete(@stations[station]) if @stations.values_at(1..-2).include?(@stations[station])
    end
  end

  def assigne_route
    if @trains.size < 1
      puts "Саначала создайте поезда"
    else
      train = @query.get_train(@trains)
      return @query.train_error if train_in_range?(train)
      route = @query.get_route_index(@routes)
      return @query.route_error if route_in_range?(route)
      @trains[train].add_route(@routes[route])
      puts "Маршрут  #{@routes[route]} назначен поезду #{@trains[train].train_number}"
    end
  end

  def assigne_cargo
   return @query.train_error unless @trains.any?
   train = @query.get_train(@trains)
   return @query.train_error if train_in_range?(train)
   if @trains[train].train_type == :passenger_train
    cargo = PassengerCarriage.new
    @wagons << cargo
    @trains[train].add_cargo(cargo)
   elsif @trains[train].train_type == :cargo_train
    cargo = CargoCarriage.new
    @wagons << cargo
    @trains[train].add_cargo(cargo)
   end
  end

  def del_cargo
   return @query.train_error unless @trains.any?
   train = @query.get_train(@trains)
   return @query.train_error if train_in_range?(train)
   cargo = @trains[train].cargoes.last
   @trains[train].remove_cargo(cargo)
  end

  def move_next_st
   return @query.train_error unless @trains.any?
   train = @query.get_train(@trains)
   return @query.train_error if train_in_range?(train)
   return if @trains[train].route.nil?
   @trains[train].go_next_station
  end

  def move_prev_st
   return @query.train_error unless @trains.any?
   train = @query.get_train(@trains)
   return @query.train_error if train_in_range?(train)
   return if @trains[train].route.nil?
   @trains[train].go_prev_station
  end

  def show_all_stations
   @stations.each { |station| puts station.station_name}
  end

  def show_station_trains
    return @query.train_error unless @trains.any?
    station = @query.get_station_index(@stations)
    return @query.station_error if station_in_range?(station)
    @stations[station].trains_in.each {|train| puts "Номер поезда #{train.train_number}, тип #{train.train_type}" }
  end

  def station_in_range?(station)
    @stations[station].nil? || station < 0
  end

  def train_in_range?(train)
    @trains[train].nil? || train < 0
  end

  def route_in_range?(route)
    @routes[route].nil? || route < 0
  end


end

rr = RailRoad.new
rr.main_menu_list
