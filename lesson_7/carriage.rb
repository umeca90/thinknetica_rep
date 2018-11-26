class Carriage
  include CompanyName
  include Validator

  CAR_REGEXP = /(^[a-zA-Z]{2}-?[0-9]{1}$)|(^[а-яА-Я]{2}-?[0-9]{1}$)/

  attr_reader :type, :car_num

  @@cars = []

  def initialize(car_num, *_args)
    @car_num = car_num.upcase
    @@cars << self
    validate!
  end

  protected

  def validate!
    raise "Неверный формат номера" if car_num !~ CAR_REGEXP
    #raise "Свободное место должно быть указано в цифрах" if self.space == 0
  end

end
