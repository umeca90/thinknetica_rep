puts "Здравствуйте, для получения суммы покупок следуйте шагам ниже"
puts "Для остановки  введите стоп"

goods_hash = {}

loop do
    puts "Введите товар"
    item = gets.chomp
    break if item == "стоп" || nil
    puts "Введите цену"
    price = gets.chomp.to_f
    puts "Введите кол-во"
    count = gets.chomp.to_f
    goods_hash[item.to_sym] = {price: price, count: count}
end

total_for_items = 0
goods_hash.each do |key, val|
     total_for_item = val[:price] * val[:count]
     total_for_items += total_for_item
     puts "Итоговая цена за #{key} = #{total_for_item}"
 end

puts "Итоговая цена за все товары =  #{total_for_items}"
