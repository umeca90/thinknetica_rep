class PassengerCarriage < Carriage
 
  def initialize(space, car_num)
    super
  end
  
  def take_space
   super(1) unless @space_taken == @space
  end

end