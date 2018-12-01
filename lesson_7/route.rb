# frozen_string_literal: true

class Route
  include InstanceCounter
  include Validator

  attr_reader :list
  @@routes = []
  def initialize(start_st, end_st)
    @list = [start_st, end_st]
    @@routes << self
    validate!
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

  protected

  class << self
    def all
      @@routes.each { |r| puts r }
    end

    def routes
      @@routes
    end
  end

  def validate!
    raise "Please fill stations" unless @list.all? { |st| st.is_a?(Station) }
    raise "First and last station must differ" if @list.first == @list.last
  end
end
