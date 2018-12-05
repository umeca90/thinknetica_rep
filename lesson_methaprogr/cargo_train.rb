# frozen_string_literal: true

class CargoTrain < Train
  validate :num, :presence
  validate :num, :format, /^\w{3}-?\w{2}$/
  def initialize(number)
    super(number, :cargo)
  end
end
