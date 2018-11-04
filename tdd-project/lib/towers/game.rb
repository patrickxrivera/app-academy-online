class Game
    attr_reader :towers

    def initialize(tower_one, tower_two, tower_three)
        @towers = [tower_one, tower_two, tower_three]
    end

    def move(from, to)
        raise 'Must input either 1, 2, or 3.' if invalid_input?(from, to)
        @towers[to - 1].plates << @towers[from - 1].plates.pop 
    end

    private
    def invalid_input?(from, to)
        valid_nums = [1, 2, 3]
        !valid_nums.include?(from) || !valid_nums.include?(to)
    end
end