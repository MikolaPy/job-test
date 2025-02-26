def from_words?(string, words)
  string_size = string.size

  cash = Array.new(string_size, false)
  cash[0] = true

  for i in (1..string_size)
    for j in (0..i)
      sub = string[j...i]
      if cash[j] && words.include?(sub)
        cash[i] = true
        break
      end
    end
  end

  return cash[string_size]
end

string_test = "двесотни"
# string_test = "incorrect_string"
words_test  = %w[две сотни тысячи]

if from_words?(string_test, words_test) 
  p 'correct string'
end
