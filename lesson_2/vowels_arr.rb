alphabet = ("a".."z").to_a
vowels = ["a", "e", "i", "o", "u"]
vowels_hash = {}

alphabet.each_with_index do |letter, index|
  vowels_hash[letter] = index + 1 if vowels.include?(letter)
end
puts vowels_hash
