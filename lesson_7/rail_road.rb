require_relative "cargo_info.rb"
require_relative "validator"
require_relative "company_name.rb"
require_relative "instance_counter"
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
  attr_reader :stations, :trains, :wagons
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
    create_all
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
      when 4
       create_cargo
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
      when 8
        take_space_in_car
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
      when 3
        train_cars_info
      when 4
        show_all_cars
      when 0
        break
      end
    end
  end
  
#station procedures
  def create_station
    begin 
      station =  @query.get_station_name.capitalize
      @stations << Station.new(station)
    rescue
      @query.station_error
      retry
    end
    @query.station_created(station)  
  end

  def show_all_stations
    @stations.each { |station| puts station.station_name}
  end

  def show_station_trains
    return @query.train_error unless @trains.any?
    station = @query.get_station_index(@stations)
    return @query.station_error if station_in_range?(station)
    @stations[station].each_train {|train| puts "Номер поезда #{train.train_number}, тип #{train.train_type} , кол-во вагонов #{train.cargoes.size}" }
  end

#train procedures  
  def create_train
    train_type = @query.get_train_type 
    return @query.train_error if train_type > 2 || train_type <= 0
    begin
      train_num = @query.get_train_num
        if train_type == 1
          @trains <<  PassengerTrain.new(train_num)
        elsif train_type == 2
          @trains << CargoTrain.new(train_num)
        end
    rescue
      @query.train_error
      retry
    end
    @query.train_created(train_num)
  end

  def assigne_route
    return @query.simple_error unless (@routes.any? && @trains.any?)
    train = @query.get_train(@trains)
    route = @query.get_route_index(@routes)
    @trains[train].add_route(@routes[route])
    puts "Маршрут  #{@routes[route]} назначен поезду #{@trains[train].train_number}"
  rescue NoMethodError
    @query.simple_error
  end

  def assigne_cargo
    return @query.train_error if @trains.empty?
    train = @query.get_train(@trains)
    return @query.train_error if train_in_range?(train)
    cargo = @query.get_car(@wagons)
    return @query.simple_error if car_in_range?(cargo)
    if @trains[train].cargoes.include?(@wagons[cargo])
      puts "Этот вагон уже прицеплен"
    else
      @trains[train].add_cargo(@wagons[cargo])
    end      
  end

  def del_cargo
    return @query.train_error if @trains.empty?
    train = @query.get_train(@trains)
    return @query.train_error if train_in_range?(train)
    @trains[train].remove_cargo unless @trains[train].cargoes.empty?
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

  def show_all_trains
   return @query.object_error if @trains.empty?
    @trains.each { |train| puts train.train_number }
  end
  
  def train_cars_info
    return @query.train_error unless @trains.any?
    train = @query.get_train(@trains)
    return @query.train_error if train_in_range?(train)
    @trains[train].cargo_info #if @trains[train].cargoes
  end

#cargo procedures
  def create_cargo
    type = @query.get_cargo_type
    return @query.simple_error if type > 2 || type <= 0
    num = @query.get_cargo_num
    cap = @query.get_cargo_cap
    if type == 1
      cargo = PassengerCarriage.new(num, cap)
      @wagons << cargo
    elsif type == 2
      cargo = CargoCarriage.new(num, cap)
      @wagons << cargo
    end
    puts "Создан вагон: тип #{cargo.type}, номер #{num}, вместимость #{cap}"
  rescue Exception => e
    puts e
  end
  
  def show_all_cars
    return @query.object_error if @wagons.empty?
    @wagons.each { |w| puts "#{w.car_num} || #{w.type}" }
  end
  
  def take_space_in_car
    return @query.simple_error if @wagons.empty?
    car = @query.get_car(@wagons)
    return @query.simple_error if car_in_range?(car)
    if  @wagons[car].is_a?(PassengerCarriage)
      @wagons[car].take_space
    else
      puts "Введите сколько занять пространства" 
      space = gets.chomp.to_i
      @wagons[car].take_space(space)
    end
  end

#route procedures
  def create_route
    return @query.simple_error if @stations.size < 2
    start = @query.get_station_index_1(@stations)
    end_st = @query.get_station_index_2(@stations)
    route =  Route.new(@stations[start],@stations[end_st])
    @routes << route
  rescue Exception => e
    puts e.message
    retry
  end

  def add_st_to_route
    return @query.simple_error unless (@routes.any? && @stations.any?)
    route = @query.get_route_index(@routes) 
    station = @query.get_station_index(@stations)
    @routes[route].add_station(@stations[station]) if !@stations[station].nil?
  rescue NoMethodError
    @query.simple_error 
  end

  def del_station_from_route
    return @query.simple_error unless (@routes.any? && @stations.any?)
    route = @query.get_route_index(@routes)
    station = @query.get_station_index(@stations)
    @routes[route].stations_list.delete(@stations[station]) if @stations.values_at(1..-2).include?(@stations[station])
  rescue NoMethodError
    @query.simple_error
  end

#help methods
  def station_in_range?(station)
    @stations[station].nil? || station < 0
  end

  def train_in_range?(train)
    @trains[train].nil? || train < 0
  end

  def route_in_range?(route)
    @routes[route].nil? || route < 0
  end
  
  def car_in_range?(wagon)
    @wagons[wagon].nil? || wagon < 0
  end  

   
  def create_all

    @wagons << PassengerCarriage.new("po2",5)
    @wagons << PassengerCarriage.new("po3",5)
    @wagons << CargoCarriage.new("do3",44)
    @trains << PassengerTrain.new('fff-22')
    @trains << CargoTrain.new('ccc-44')
    @stations << Station.new("moscow")
    @stations << Station.new("petersburg")
    @routes << Route.new(@stations[0], @stations[1])

  end


end

rr = RailRoad.new
rr.main_menu_list
