puts "Теорема Пифагора"
puts "Введите значение для стороны А"
side_a = gets.chomp.to_f
puts "Введите значение для стороны B"
side_b = gets.chomp.to_f
puts "Введите значение для стороны C"
side_c = gets.chomp.to_f

a, b, c = [side_a, side_b, side_c].sort
  right_angled = c**2 == a**2 + b**2


  if right_angled && (a == b)
    puts "Треугольник является прямоугольным и равнобедренным"
  elsif right_angled
    puts "Треугольник является прямоугольным"
  elsif (c == b) && (c == a) && (a == b)
    puts "Треугольник является равносторонним и равнобедренным"
  elsif (c == b) || (c == a) || (a == b)
    puts "Треугольник является равнобедренным"
  else
    puts "Обычный треугольник"
  end
