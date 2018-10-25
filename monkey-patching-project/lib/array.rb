# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
    def span
        self.any? ? self.max - self.min : nil
    end  

    def average
        self.any? ? self.reduce { |sum, num| sum + num } / self.length.to_f : nil
    end

    def median
        return nil unless self.any?

        sorted = self.sort

        self.even? ? (sorted[self.mid - 1].to_f + sorted[self.mid]) / 2 : sorted[self.mid]
    end

    def counts
        counter = Hash.new(0)

        self.each { |char| counter[char] += 1 }

        counter
    end

    def my_count(num)
        count = 0
        
        self.each do |curr_num|
            count += 1 if curr_num == num
        end

        count
    end

    def my_index(char)
        self.each_with_index do |curr_char, idx|
            return idx if curr_char == char
        end
        
        nil
    end

    def my_uniq
        self.reduce([]) do |result, curr|
            result << curr unless result.include?(curr)
            result
        end    
    end

    def my_transpose
        self.each_with_index do |char1, idx1|
            (idx1...self[0].length).each do |idx2|
                self[idx1][idx2], self[idx2][idx1] = self[idx2][idx1], self[idx1][idx2] 
            end
        end
    end

    def even?
        self.length % 2 == 0
    end

    def mid
        (self.length / 2).floor
    end
end 
