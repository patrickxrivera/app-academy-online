# EASY

# Return the argument with all its lowercase characters removed.
def destructive_uppercase(str)
    is_uppercase = lambda { |char| char == char.upcase }
    str.chars.select(&is_uppercase).join    
end

# Return the middle character of a string. Return the middle two characters if
# the word is of even length, e.g. middle_substring("middle") => "dd",
# middle_substring("mid") => "i"
def middle_substring(str)
    len = str.length
    midpoint = (len / 2).floor
    len.odd? ? str[midpoint] : str[midpoint - 1..midpoint]
end

# Return the number of vowels in a string.
VOWELS = 'aeiouAEIOU'
def num_vowels(str)
   str.count(VOWELS) 
end

# Return the factoral of the argument (num). A number's factorial is the product
# of all whole numbers between 1 and the number itself. Assume the argument will
# be > 0.
def factorial(num)
    product = 1
    curr_num = 2
    while curr_num <= num
      product *= curr_num
      curr_num += 1
    end
    product    
end


# MEDIUM

# Write your own version of the join method. separator = "" ensures that the
# default seperator is an empty string.
def my_join(arr, separator = "")
    result = ""
    last_idx = arr.length - 1
    arr.each_with_index do |char, idx|
      result += idx == last_idx ? char : char + separator
    end
    result
end

# Write a method that converts its argument to weirdcase, where every odd
# character is lowercase and every even is uppercase, e.g.
# weirdcase("weirdcase") => "wEiRdCaSe"
def weirdcase(str)
    result = ''
    str.each_char.with_index do |char, idx|
      result += idx.odd? ? char.upcase : char.downcase
    end
    result
end

# Reverse all words of five more more letters in a string. Return the resulting
# string, e.g., reverse_five("Looks like my luck has reversed") => "skooL like
# my luck has desrever")
def reverse_five(str)
    handle_reverse = lambda { |word| word.length >= 5 ? word.reverse : word }
    str.split.map(&handle_reverse).join(' ')
end

# Return an array of integers from 1 to n (inclusive), except for each multiple
# of 3 replace the integer with "fizz", for each multiple of 5 replace the
# integer with "buzz", and for each multiple of both 3 and 5, replace the
# integer with "fizzbuzz".
def fizzbuzz(n)
    result, count = [], 1
    while count <= n
      if count % 15 == 0
        result << 'fizzbuzz'
      elsif count % 3 == 0
        result << 'fizz'
      elsif count % 5 == 0
        result << 'buzz'
      else
        result << count
      end
      count += 1
    end
    result
  end


# HARD

# Write a method that returns a new array containing all the elements of the
# original array in reverse order.
def my_reverse(arr)
    result = []
    arr.reverse.each { |char| result << char }
end

# Write a method that returns a boolean indicating whether the argument is
# prime.
def prime?(num)
    midpoint = (num / 2).floor
    is_prime = lambda { |curr_num| num % curr_num != 0 }
    num == 1 ? false : (2..midpoint).all?(&is_prime) 
end

# Write a method that returns a sorted array of the factors of its argument.
def factors(num)
  result = []
  is_factor = lambda { |curr_num| num % curr_num == 0 }
  (1..num).select(&is_factor) 
end

# Write a method that returns a sorted array of the prime factors of its argument.
def prime_factors(num)
    factors(num).select { |n| prime?(n) }
end

# Write a method that returns the number of prime factors of its argument.
def num_prime_factors(num)
    prime_factors(num).length
end


# EXPERT

# Return the one integer in an array that is even or odd while the rest are of
# opposite parity, e.g. oddball([1,2,3]) => 2, oddball([2,4,5,6] => 5)
def odd_or_even?(num_one, num_two, num_three, *rest)
    if num_one.even? && num_two.even?
      return 'even'
    elsif num_one.odd? && num_two.odd?
      return 'odd'
    else
      return num_three.even? ? 'odd' : 'even'
    end
  end
  
  def oddball(arr)
      odd_or_even = odd_or_even?(*arr)
      arr.find { |num| odd_or_even == 'even' ? num.even? : num.odd? }
  end
