class Route
attr_reader :stations_list
#Имеет начальную и конечную станцию, а также список промежуточных станций.
#Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
def initialize(start_st, end_st)
  @stations_list = [start_st, end_st]
end
#Может добавлять промежуточную станцию в список
def add_station(station)
  @tations_list.insert(-2, station)
end
#Может удалять промежуточную станцию из списка
def del_station(station)
  @stations_list.delete(station) if station != self.stations_list[0] && station != self.stations_list[-1]
end
#Может выводить список всех станций по-порядку от начальной до конечно
def show_stations
  stations_list.each {|station| puts station.station_name}
end

end
