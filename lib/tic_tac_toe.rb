require 'pry'

class TicTacToe

    WIN_COMBINATIONS = [
        [0,1,2], 
        [3,4,5],
        [6,7,8],
        [0,4,8],
        [2,4,6],
        [0,3,6],
        [1,4,7],
        [2,5,8]
    ]

    attr_accessor :board
    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    #main loop method to run game
    def play
        until over?
            turn
            if draw?
                return
            end
            #binding.pry
        end

       puts won? ? "Congratulations #{winner}!" : "Cat's Game!"
    end
        


    #helper methods
    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input)
        user_input = user_input.to_i - 1
        user_input
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        case @board[index]
        when " "
            false
        else
            true
        end
    end

    def valid_move?(position)
        position.between?(0,8) && !position_taken?(position)
    end

    def turn_count
        @board.length - @board.count(" ")
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Choose a position between 1 - 9"
        input = gets.strip
        index = input_to_index(input)

        player = current_player
        case valid_move?(index)
        when true
            move(index, player)
            display_board
        else 
            puts "Choose a new valid input"
            turn
        end
        #display_board
    end

    def won?
         WIN_COMBINATIONS.any? {|array| #0,4,8
            if position_taken?(array[0]) && @board[array[0]] == @board[array[1]] && @board[array[0]] == @board[array[2]]
                return array
            end
            }
    end

    def full?
        @board.all? {|x| x != " "}
    end

    def draw?
        full? && !won?
    end

    def over?
        full? || won?
    end

    def winner
        won? ?
        @board[won?[0]] :
        nil
    end
end

#binding.pry
