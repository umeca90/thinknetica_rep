# frozen_string_literal: true

class CargoCarriage < Carriage
  attr_reader :space, :taken_space

  def initialize(space)
    @type = :cargo
    @space = space
    @taken_space = 0
    # validate!
    super
  end

  def take_space
    puts "Введите сколько занять пространства"
    space = gets.chomp.to_i
    @taken_space += space unless space + @taken_space > @space
  end

  def free_space
    @space - @taken_space
  end
end
