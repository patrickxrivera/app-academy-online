class Board
    attr_reader :size

    def self.print_grid(grid)
        grid.each do |row|
            print row.join(' ') + "\n"
        end
    end

    def initialize(n)
        @n = n
        @grid = init_grid(@n)
        @size = n ** 2
    end  

    def [](position)
        row, col = position
        @grid[row][col]
    end

    def []=(position, val)
        row, col = position
        @grid[row][col] = val
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(@hidden_ships_grid)
    end
    
    def num_ships
        @grid.reduce(0) do |total, row| 
            total += row.count(:S)
            total
        end
    end

    def attack(position)
        hit?(*position) ? handle_hit(*position) : handle_miss(*position)
    end

    def place_random_ships
        count = 0

        until reached_limit?(count)
            rand_row, rand_col = rand(0...@n), rand(0...@n)
            if not_set?(rand_row, rand_col)
                @grid[rand_row][rand_col] = :S
                count += 1
            end
        end
    end

    def hidden_ships_grid
        @grid.each_with_index.map do |row, rowIdx|
            row.each_with_index.map do |val, colIdx|
                val == :S ? :N : val
            end
        end
    end

    private
    def init_grid(n)
        grid = Array.new(n) { Array.new(n) }
        grid.map { |row| row.map! { :N } }
    end

    def reached_limit?(count)
        count / @size.to_f >= 0.25
    end

    def not_set?(row, col)
        @grid[row][col] == :N
    end

    def hit?(row, col)
        @grid[row][col] == :S
    end

    def handle_hit(row, col)
        @grid[row][col] = :H 
        p 'you sunk my battleship!'
        true
    end

    def handle_miss(row, col)
        @grid[row][col] = :X
        false 
    end
end