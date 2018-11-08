alphabet = ("a".."z").to_a
vowels = ["a", "e", "i", "o", "u"]
vowels_hash = Hash.new(0)
i = 0
alphabet.each_with_index do |letter, index|
  for i in vowels do
    if letter.include?(i)
      vowels_hash[letter.to_sym] = index + 1
    end
  end
end
puts vowels_hash
