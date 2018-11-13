class Cargo
  attr_reader :type, :info
  attr_accessor :train, :number
  def initialize(type = :cargo || :passenger)
    @type = type
  end
end
