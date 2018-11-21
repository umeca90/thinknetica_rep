class Route
  include InstanceCounter
  include Validator

  attr_reader :stations_list

  def initialize(start_st, end_st)
    @stations_list = [start_st, end_st]
    validate!
    register_instance
  end

  def add_station(station)
    @stations_list.insert(-2, station) unless @stations_list.include?(station)
  end

  def del_station(station)
    @stations_list.delete(station)
  end


  def show_stations
    @stations_list.each {|station| print "#{station.station_name} | "}
  end

  protected

  def validate!
    raise "Станции должны быть заполнены!" unless @stations_list.all?{|st| st.is_a?(Station)}
    raise "Начальная и конечная станции должны отличаться!" if @stations_list.first == @stations_list.last
  end
end
