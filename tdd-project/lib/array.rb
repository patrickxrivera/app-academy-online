require 'set'

class Array
    def initialize
    end
    
    def my_uniq(array)
        set = Set.new
        
        array.reduce([]) do |result, val|
            result << val unless set.include?(val)
            set.add(val)
            result
        end
    end

    def two_sum(array)
        array.each_with_index.reduce([]) do |result, pair|
            headVal, headIdx = pair
            complement = headVal * -1
    
            (headIdx + 1...array.length).each do |tailIdx|
                result << [headIdx, tailIdx] if array[tailIdx] == complement
            end
    
            result
        end
    end
end