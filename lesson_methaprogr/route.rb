# frozen_string_literal: true

require_relative "station"
class Route
  include InstanceCounter
  include Validation

  attr_reader :list

  validate :start_st, :type, Station
  validate :end_st, :type, Station

  class << self
    def all
      @@routes.each { |r| puts r }
    end

    def routes
      @@routes
    end
  end

  @@routes = []
  def initialize(start_st, end_st)
    @start_st = start_st
    @end_st = end_st
    @list = [start_st, end_st]
    validate!
    @@routes << self
    register_instance
  end

  def add_station(station)
    @list.insert(-2, station) unless @list.include?(station)
  end

  def del_station(station)
    @list.delete(station) if @list.last != station && rist.first != station
  end

  def show_stations
    @list.each { |station| print "#{station.name} | " }
  end
end
