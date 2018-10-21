require 'byebug'

def prime?(num)
    (2...num).each do |idx|
      if num % idx == 0
        return false
      end
    end

    true
end
  
def primes(num_primes)
    ps = []
    num = 1
    while ps.count < num_primes
      primes << num if prime?(num)
    end
end
  
if $PROGRAM_NAME == __FILE__
    puts primes(100)
end