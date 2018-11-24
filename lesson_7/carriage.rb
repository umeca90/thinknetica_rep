class Carriage
  include CompanyName
  include Validator

  CAR_REGEXP = /(^[a-zA-Z]{2}-?[0-9]{1}$)|(^[а-яА-Я]{2}-?[0-9]{1}$)/

  attr_reader :type, :space, :space_taken, :car_num

  @@cars = []

  def initialize(car_num, space)
    @type = self.class
    @space = space
    @space_taken = 0
    @car_num = car_num.upcase
    @@cars << self
    validate!
  end

  def take_space(space)
    @space_taken += space
  end

  def space_available
    @space - @space_taken
  end

  protected

  def validate!
    raise "Неверный формат номера" if car_num !~ CAR_REGEXP
    raise "Свободное место должно быть указано в цифрах" if self.space == 0
  end

end
