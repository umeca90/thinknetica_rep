# frozen_string_literal: true

require_relative "accessors"
require_relative "cargo_info"
require_relative "validation"
require_relative "company_name"
require_relative "instance_counter"
require_relative "train"
require_relative "station"
require_relative "route"
require_relative "carriage"
require_relative "passenger_train"
require_relative "cargo_train"
require_relative "passenger_carriage"
require_relative "cargo_carriage"
require_relative "main_query"
require_relative "create_menu"
require_relative "objects_menu"
require_relative "info_menu"
class RailRoad
  include Validation

  LIST = ["Введите 1, если хотите создать станцию, маршрут, поезд, вагон",
          "Введите 2, если произвести операции с созданными обьектами",
          "Введите 3, если хотите получить данные об обьекте",
          "Введите 0, Выход"].freeze

  MAIN_MENU_METHS = { 1 => :create_menu,
                      2 => :operations_list,
                      3 => :info_list }.freeze

  attr_reader :stations, :trains, :wagons
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
    seed_stations
    seed_trains
    seed_cars
    seed_routes
  end

  def start
    loop do
      puts LIST
      choice = gets.chomp.to_i
      send MAIN_MENU_METHS[choice] || break
    end
  end

  private # This methods only for user menu.

  def create_menu
    menu = CreateMenu.new
    choice = gets.chomp.to_i
    menu.create_method(choice)
  end

  def operations_list
    menu = ObjectsMenu.new
    choice = gets.chomp.to_i
    menu.objects_method(choice)
  end

  def info_list
    menu = InfoMenu.new
    choice = gets.chomp.to_i
    menu.info_methods(choice)
  end

  def seed_stations
    Station.new("moscow")
    Station.new("peterburg")
    Station.new("tver")
  end

  def seed_trains
    PassengerTrain.new("fff-22")
    CargoTrain.new("ccc-44")
  end

  def seed_cars
    PassengerCarriage.new(5)
    PassengerCarriage.new(5)
    CargoCarriage.new(44)
  end

  def seed_routes
    Route.new(Station.all["moscow"], Station.all["peterburg"])
  end
end

rr = RailRoad.new
rr.start
