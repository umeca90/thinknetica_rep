class Carriage
  include CompanyName
  attr_reader :type
  
  def initialize(type)
    @type = type
  end
end
