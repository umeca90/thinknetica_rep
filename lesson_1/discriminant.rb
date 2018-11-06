puts "Доброго времени суток, введите коофициенты для решения уравнения"
puts "введите коэффициент a"
a = gets.chomp.to_f
puts "введите коэффициент в"
b = gets.chomp.to_f
puts "введите коэффициент с"
c = gets.chomp.to_f
disc = b**2 - 4 * a * c
if disc > 0
  d_root = Math.sqrt(d)
  x1 = (-b + d_root) / (2 * a)
  x1 = (-b - d_root) / (2 * a)
  puts "Discriminant = #{disc}, X1 = #{x1}, X2 = #{x2}"
elsif disc == 0
  x = -b / (2 * a)
  puts "Discriminant = #{disc}, X = #{x}, корень один, т.к. корни равны."
elsif disc < 0
   puts "Discriminant = #{disc}, Корней нет!"
 end
