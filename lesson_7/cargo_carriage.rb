class CargoCarriage < Carriage

  attr_reader :space, :taken_space

  def initialize(car_num, space)
    @type = self.class
    @space = space
    @taken_space = 0
    super
    @@cars << self
  end

  def take_space(space)
    @taken_space += space unless space + @taken_space > @space
  end

  def space_available
    @space - @taken_space
  end

  protected

  def validate!
    raise "Вместимость должна быть указана в цифрах" if self.space == 0
  end

end
