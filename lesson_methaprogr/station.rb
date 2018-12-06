# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validation
  extend Accessors

  attr_accessor_with_history :name, :trains_in
  validate :name, :presence
  validate :name, :format, /^([a-zA-Z0-9]{4,}$)|^([а-яА-Я0-9]{4,}$)/
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
    validate!
    @trains_in = []
    register_instance
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
end
