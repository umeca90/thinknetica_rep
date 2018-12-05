# frozen_string_literal: true

require_relative "accessors.rb"
require_relative "cargo_info.rb"
require_relative "validation"
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
require_relative "create_menu.rb"
require_relative "objects_menu.rb"

class InfoMenu
  include CargoInfo
  include QueryMethods

  PRINT = ["Введите 1, чтобы посмотреть список всех станций",
           "Введите 2, чтобы посмотреть список всех поездов", \
           "на определённой станции",
           "Введите 3, список  поездов и его вагонов",
           "Введите 4, чтобы посмотреть список всех созданных вагонов",
           "Назад 0"].freeze

  INFO_METHODS = { 1 => :show_all_stations,
                   2 => :show_station_trains,
                   3 => :train_cars_info,
                   4 => :show_all_cars }.freeze

  def initialize
    puts PRINT
  end

  def info_methods(choice)
    send INFO_METHODS[choice] || return
  end

  private

  def show_all_stations
    Station.all.each_key { |k| puts k }
  end

  def show_station_trains
    return if Train.trains_all.nil?

    station = ask_station
    return station_error if station.nil?

    station.each_train do |train|
      puts "№ #{train.num},тип #{train.type} ,вагонов #{train.cars.size}"
    end
  end

  def train_cars_info
    return object_error if Train.trains_all.nil?

    train = ask_train
    return train_error if train.nil?

    train.cargo_info
  end

  def show_all_cars
    return object_error if Carriage.cars.empty?

    Carriage.cars.each { |c| puts "#{c}, #{c.type}" }
  end
end
