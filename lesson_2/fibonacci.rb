require 'active_support'
require 'active_support/core_ext'
fibo_arr = [0, 1]
while fibo_arr.last(2).sum < 100
  fibo_arr << fibo_arr[-1] + fibo_arr[-2]
end
puts fibo_arr
