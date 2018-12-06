# frozen_string_literal: true

require_relative "route"
class Train
  include CompanyName
  include InstanceCounter
  include Validation
  include CargoInfo
  extend  Accessors

  attr_reader :speed, :cars, :num, :type
  strong_attr_accessor :route, Route
  validate :num, :presence
  validate :num, :format, /^\w{3}-?\w{2}$/
  @@trains_all = {}

  def initialize(num, type)
    @num = num
    @type = type
    validate!
    @speed = 0
    @cars = []
    trains_list
    register_instance
  end

  class << self
    def find(num)
      @@trains_all[num]
    end

    def trains_all
      @@trains_all
    end
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
    @st_pos = 0
    @route.list[0].check_in(self)
  end

  def go_next_station
    return unless next_station

    current_station.check_out(self)
    @st_pos += 1
    current_station.check_in(self)
  end

  def go_prev_station
    return unless prev_station

    current_station.check_out(self)
    @st_pos -= 1
    current_station.check_in(self)
  end

  def add_cargo(car)
    return if move? || @cars.include?(car)
    return if car.type != @type

    @cars << car
  end

  def remove_cargo
    return if move?

    @cars.pop
  end

  def each_cargo
    @cars.each { |car| yield(car) }
  end

  protected

  # Available for subclasses
  def move?
    @speed.positive?
  end

  def current_station
    route.list[@st_pos]
  end

  def next_station
    route.list[@st_pos + 1]
  end

  def prev_station
    route.list[@st_pos - 1] unless @st_pos.zero?
  end

  def trains_list
    @@trains_all[num] = self
  end
end
