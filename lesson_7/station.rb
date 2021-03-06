# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validator

  STATION_REGEXP = /^([a-zA-Z0-9]{4,}$)|^([а-яА-Я0-9]{4,}$)/.freeze

  attr_reader :name, :trains_in
  @@stations = {}

  class << self
    def all
      @@stations
    end

    def find_by_name(name)
      @@stations[name]
    end
  end

  def initialize(name)
    @name = name
    @trains_in = []
    register_instance
    validate!
    @@stations[name] = self
  end

  def check_in(train)
    @trains_in << train
  end

  def check_out(train)
    @trains_in.delete(train)
  end

  def trains_by_type(tr_type)
    @trains_in.select { |train| train.type == tr_type }
  end

  def each_train
    @trains_in.each { |train| yield(train) }
  end

  protected

  def validate!
    raise "Bad station name format" if name !~ STATION_REGEXP
  end
end
