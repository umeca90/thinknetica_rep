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
    #Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирски
    def total_trains_by_type(tr_type)
      trains_in.select { |train| train.train_type == tr_type}
    end
end
