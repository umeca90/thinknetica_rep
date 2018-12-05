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
class CreateMenu
  include QueryMethods

  PRINT = ["Введите 1, чтобы создать станцию",
           "Введите 2, чтобы создать маршрут",
           "Введите 3, чтобы создать поезд",
           "Введите 4, чтобы создать вагон",
           "Назад 0"].freeze

  CREATE_METHODS = { 1 => :create_station,
                     2 => :create_route,
                     3 => :create_train,
                     4 => :create_cargo }.freeze

  def initialize
    puts PRINT
  end

  def create_method(choice)
    send CREATE_METHODS[choice] || return
  end

  def create_station
    begin
      name = ask_station_name
      station = Station.new(name)
    rescue StandardError => e
      puts e
      retry
    end
    station_created(station) if station.valid?
  end

  def create_train
    type = ask_train_type
    return train_error unless (1..2).cover?(type)

    num = ask_train_num
    if type == 1
      PassengerTrain.new(num)
    elsif CargoTrain.new(num)
    end
  rescue StandardError => e
    puts e
  end

  def create_route
    return simple_error if Station.instances < 2

    start = ask_station
    end_st = ask_station
    return simple_error if start.nil? || end_st.nil?

    Route.new(start, end_st)
    puts "Новый маршрут создан!"
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_cargo
    type = ask_cargo_type
    return simple_error unless (1..2).cover?(type)

    cap = ask_cargo_cap
    if type == 1
      PassengerCarriage.new(cap)
    elsif CargoCarriage.new(cap)
    end
    puts "Вагон успешно создан!"
  rescue StandardError => e
    puts e
  end
end
