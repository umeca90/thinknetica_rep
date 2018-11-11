class Station
    attr_reader :trains_in, :station_name
    #Имеет название, которое указывается при ее создании
    def initialize(station_name)
      @station_name = station_name
      @trains_in = []
    end
    #Может принимать поезда (по одному за раз)
    def check_in(train)
      @trains_in << train
    end
    #Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
    def check_out(train)
      @trains_in.delete(train)
    end
    #Может возвращать список всех поездов на станции, находящиеся в текущий момент
    def total_trains_in
      @trains_in.each {|train| puts "Номер поезад #{train.train_number}, тип #{train.train_type}"}
    end
    #Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирски
    def total_trains_by_type
      trains_in__by_type = []
      @trains_in.each {|train| trains_in__by_type << train.train_type}
      trains_in__by_type.group_by{|type| type}.map{|k, v| puts "тип поезда:#{k} кол-во на станции сейчас #{v.size}"}
    end
end
