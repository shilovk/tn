# frozen_string_literal: true

# 4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

def vowel?(letter)
  'aeiou'.include?(letter)
end

vowels = ('a'..'z').each_with_index.each_with_object({}) do |(letter, i), memo|
  memo[letter] = i if vowel?(letter)
end

puts vowels
