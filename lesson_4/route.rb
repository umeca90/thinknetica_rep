class Route
attr_reader :stations_list

def initialize(start_st, end_st)
  @stations_list = [start_st, end_st]
end

def add_station(station)
  if @stations_list.include?(station)
    puts "Данная станция уже в маршруте"
  else
    @stations_list.insert(-2, station)
    puts "Добавленая станция #{station}"
  end
end

def del_station(station)
  @stations_list.delete(station)
end
  

def show_stations
  @stations_list.each {|station| print "#{station.station_name} | "}
end

end