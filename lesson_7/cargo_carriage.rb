class CargoCarriage < Carriage

  def initialize(space, car_num)
    super
  end

  def take_space(space)
    super(space) unless space + @space_taken > @space
  end

end
