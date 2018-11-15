class Station
    attr_reader :station_name, :trains_in
    
    def initialize(station_name)
      @station_name = station_name
      @trains_in = []
    end
    
    def check_in(train)
      @trains_in << train
    end
    
    def check_out(train)
      @trains_in.delete(train)
    end
    
    def trains_by_type(tr_type)
      @trains_in.select { |train| train.train_type == tr_type}
    end
end