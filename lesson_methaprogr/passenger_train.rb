# frozen_string_literal: true

class PassengerTrain < Train
  validate :num, :presence
  validate :num, :format, /^\w{3}-?\w{2}$/
  def initialize(number)
    super(number, :passenger)
  end
end
