puts "Здравствуйте, я  определю Ваш оптимальный вес."
print "Введите ваше имя "
user_name = gets.chomp
user_name.capitalize!
print "Введите ваш рост в сантиметрах "
user_height = gets.chomp
perfect_weight = user_height.to_i - 110
if perfect_weight < 0
  puts "#{user_name}, puts ваш вес уже оптимальный"
else
  puts "#{user_name}, ваш идеальный вес #{perfect_weight}"
end
