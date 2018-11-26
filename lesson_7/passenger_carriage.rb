class PassengerCarriage < Carriage

  attr_reader :seats, :taken_seats

  def initialize(car_num, seats)
    @type = self.class
    @seats = seats
    @taken_seats = 0
    super
    @@cars << self
  end

  def take_seat
    @taken_seats += 1 unless @taken_seats == @seats
  end

  def seats_available
    @seats - @taken_seats
  end

  protected

  def validate!
    raise "Количество пассажирских мест должно быть указано в цифрах" if self.seats == 0
  end

end
