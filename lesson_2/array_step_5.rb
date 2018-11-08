my_arr_1 = []
index = 10
until index > 100
  if index % 5 == 0
    my_arr_1 << index
    index += 5
  end
end
puts my_arr_1


my_arr_2 = (10..100).step(5).to_a
puts my_arr_2
