# 4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

def vowel?(letter)
  'aeiou'.include?(letter)
end

vowels = ('a'..'z').each_with_index.inject( {} ) do |memo, (letter, i)|
  memo[letter] = i if vowel?(letter)
  memo
end

puts vowels