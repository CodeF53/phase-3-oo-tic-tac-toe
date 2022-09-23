class TicTacToe
    attr_accessor :board

    WIN_COMBINATIONS = [
        [0,1,2], # row 1
        [3,4,5], # row 2
        [6,7,8], # row 3
        [0,3,6], # col 1
        [1,4,7], # col 2
        [2,5,8], # col 3
        [0,4,8], # \
        [6,4,2]  # /
    ]

    def initialize
        @board = [" "]*9
    end

    def display_board
        puts "-----------"
        board.each.with_index do |s, i|
            if (i==0)
                print " "
            end
            if (i%3==2)
                print s + " \n "
            else
                print s + " | "
            end
        end
    end

    def input_to_index (index) index.to_i - 1 end

    def move (index, token = "X") @board[index] = token end

    def position_taken? (index) !(@board[index]==" ") end

    def valid_move? (index) index.between?(0,8) && !position_taken?(index) end

    def turn_count() @board.sum {|e| e!=" "? 1:0 } end

    def current_player() turn_count%2==0? "X" : "O" end

    def turn
        index = input_to_index(gets[0])
        if valid_move?(index)
            move(index, current_player)
            display_board
        else
            puts "invalid move"
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.each do |combo|
            # High quality var names are important
            rtrdh = combo.map {|i| @board[i] }.uniq
            if rtrdh.length == 1
                if rtrdh[0] != " "
                    return combo
                end
            end
        end
        false
    end

    def full?() !(@board.include?(" ")) end

    def draw?() full? && !won? end

    def over?() won? || draw? end

    def winner
        if (won?)
            @board[won?[0]]
        end
    end

    # until the game is over
    #     take turns
    # end

    # if the game was won
    #     congratulate the winner
    # else if the game was a draw
    #     tell the players it ended in a draw
    # end
    def play
        until over?
            turn
        end
        if won?
            puts "Congragulations #{winner}!"
        else
            puts "Cat's Game!"
        end
    end
end
