class Station
  include InstanceCounter
  include Validator

  STATION_REGEXP = /^([a-zA-Z0-9]{4,}$)|^([а-яА-Я0-9]{4,}$)/

  attr_reader :station_name, :trains_in
  @@stations = []

  def self.all
    @@stations
  end

  def initialize(station_name)
    @station_name = station_name.capitalize
    @trains_in = []
    @@stations << self
    register_instance
    validate!
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

  def each_train
    @trains_in.each { |train| yield(train) }
  end

  protected


  def validate!
    raise "Неверный формат станции" if station_name !~ STATION_REGEXP
  end

end
