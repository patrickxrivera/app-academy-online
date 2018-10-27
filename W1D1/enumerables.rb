class Array
    def my_each
        self.length.times { |i| yield self[i] }
        self
    end

    def my_select
        self.reduce([]) do |result, val| 
            result << val if yield val
            result
        end
    end

    def my_reject
        self.reduce([]) do |result, val|
            result << val unless yield val
            result
        end
    end

    def my_any?
        self.my_each do |val|
            return true if yield val
        end
        
        false
    end

    def my_all?
        self.my_each do |val|
            return false unless yield val
        end
        
        true
    end

    def my_flatten
        self.reduce([]) do |final_result, val|
            curr_result = val.kind_of?(Array) ? val.my_flatten : val
            final_result.push(*curr_result)
        end
    end

    def my_zip(*args)
        self.each_with_index.reduce([]) do |final_result, pair|
            val, idx = pair
            curr_result = [val]
            
            args.each { |elem| curr_result << elem[idx] }
            
            final_result << curr_result
        end
    end

    def my_rotate(offset=1)
        split_idx = offset % self.length
        
        self.drop(split_idx) + self.take(split_idx)
    end

    def my_join(separator='')
        self.each_with_index.reduce('') do |result, pair|
            val, idx = pair
            result += last?(idx) ? val : val + separator
        end
    end

    def my_reverse
        self.reduce([]) do |result, val|
            result.unshift(val)
        end
    end

    private
    def last?(idx)
        idx == self.length - 1
    end
end