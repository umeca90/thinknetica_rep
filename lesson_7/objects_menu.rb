# frozen_string_literal: true

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
require_relative "create_menu.rb"
require_relative "objects_menu.rb"

class ObjectsMenu
  include QueryMethods

  PRINT = ["Введите 1, добавить станцию к маршруту",
           "Введите 2, удалить станцию из маршрута",
           "Введите 3, назначит маршрут поезду",
           "Введите 4, прицепить вагон поезду",
           "Введите 5, отцепить вагон поезду",
           "Введите 6, переместить поезд вперёд на станцию",
           "Введите 7, переместить поезд назад на станцию",
           "Введите 8, занять пространство в вагоне",
           "Назад 0"].freeze

  OBJECTS_METHS = { 1 => :add_st_to_route,
                    2 => :del_station_from_route,
                    3 => :assigne_route,
                    4 => :assigne_cargo,
                    5 => :del_cargo,
                    6 => :move_next_st,
                    7 => :move_prev_st,
                    8 => :take_space_in_car }.freeze

  def initialize
    puts PRINT
  end

  def objects_method(choice)
    send OBJECTS_METHS[choice] || return
  end

  def add_st_to_route
    return object_error if Route.instances.zero? && Station.instances.zero?

    route = ask_route
    return simple_error if route.nil?

    station = ask_station
    route.add_station(station)
  rescue StandardError => e
    e.inspect
  end

  def del_station_from_route
    return object_error if Route.instances.zero? && Station.instances.zero?

    route = ask_route
    station = ask_station
    return simple_error if station.nil? || route.nil?

    route.list.delete(station)
  end

  def assigne_route
    return object_error if Route.instances.zero? && Train.trains_all.nil?

    train = ask_train
    route = ask_route
    train.add_route(route) unless train.nil? || route.nil?
  rescue NoMethodError => e
    puts e.inspect
  end

  def assigne_cargo
    return train_error if Train.trains_all.nil? || Carriage.cars.empty?

    train = ask_train
    return train_error if train.nil?

    car = ask_car
    return simple_error if car.nil?

    train.add_cargo(car)
  end

  def del_cargo
    return train_error if Train.trains_all.nil?

    train = ask_train
    return train_error if train.nil?

    train.remove_cargo unless train.cars.empty?
  end

  def move_next_st
    return train_error if Train.trains_all.nil?

    train = ask_train
    return train_error if train.nil?

    train.go_next_station unless train.route.nil?
  end

  def move_prev_st
    return train_error if Train.trains_all.nil?

    train = ask_train
    return train_error if train.nil?

    train.go_prev_station unless train.route.nil?
  end

  def take_space_in_car
    return simple_error if Carriage.cars.nil?

    car = ask_car
    return simple_error if car.nil?

    if car.type == :passenger
      car.take_seat
    else
      car.take_space
    end
  rescue StandardError => e
    puts e.inspect
  end
end
