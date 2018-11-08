fibo_arr = [0, 1]
index = 1
while fibo_arr[index] < 100 - fibo_arr[-2]
  index += 1
  fibo_arr[index] = fibo_arr[-1] + fibo_arr[-2]
end
puts fibo_arr
