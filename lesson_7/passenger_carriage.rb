# frozen_string_literal: true

class PassengerCarriage < Carriage
  attr_reader :seats, :taken_seats

  def initialize(seats)
    @type = :passenger
    @seats = seats
    @taken_seats = 0
    super
  end

  def take_seat
    @taken_seats += 1 unless @taken_seats == @seats
  end

  def free_seats
    @seats - @taken_seats
  end

  protected

  def validate!
    raise "Initial number of seats must be digit" if seats.zero?
  end
end
