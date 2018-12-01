# frozen_string_literal: true

class Carriage
  include CompanyName
  include Validator
  include InstanceCounter

  attr_reader :type, :num

  @@cars = []

  class << self
    def all
      @@cars.each { |c| puts c }
    end

    def cars
      @@cars
    end
  end

  def initialize(*_args)
    @num = self.class.instances
    @@cars << self
    register_instance
    validate!
  end
end
