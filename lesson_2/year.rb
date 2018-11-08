require 'active_support'
require 'active_support/core_ext'
month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "Я определяю порядковый номер даты в году"
puts "Введите дату"
date = gets.chomp.to_i
puts "Введите номер месяца"
month = gets.chomp.to_i
puts "Введите год"
year = gets.chomp.to_i



if year % 4 == 0 && (year % 100 != 0  || year % 400 == 0)
    month_days[1] = 29
else
    month_days
end

day_pos = month_days.take(month - 1).sum + date

puts "Порядковый номер введенной даты #{day_pos}."
