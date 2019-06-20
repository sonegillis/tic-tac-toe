require 'colorize'

class Game
  def initialize
    puts "==================================================Rules=============================================================="
      puts "1. Each player selects a mark to identify him/her in the game."
      puts "2. When the game starts each player selects a position to mark. Positions range from 1 through 9 as indicated below"
      puts "2. The player who succeeds in placing three of their marks in a horizontal, vertical, or diagonal row wins the game"
      puts "3. When all the spaces on the board are exausted, the game draws"
      puts "====================================================================================================================="

    @board = Board.new
      settings
      @board.display
      print "\nPress Enter to Start"
      gets.chomp
  end

  def start
    # Use this method to start the game
    while true
      @player_1.play
      @board.display
      if check_win(@player_1.mark)
        puts "Player 1(#{@player_1.mark}) won the game!"
        return
      end
      break if @board.full?
      @player_2.play
      @board.display
      if check_win(@player_2.mark)
        puts "Player 2(#{@player_2.mark}) won the game!"
        return
      end
      break if @board.full?
    end
    puts "No one won. The Game is a draw"
  end


  @private
  class Board
    def initialize
    end

    def display
    end

    def full?
    end
  end

  class Player
    def initialize
    end

    def play
    end
  end

  def settings
  end

  def check_win(mark)
    wincond=[
              [[0,0],[0,1],[0,2]],
              [[1,0],[1,1],[1,2]],
              [[2,0],[2,1],[2,2]],
              [[0,0],[1,0],[2,0]],
              [[0,1],[1,1],[2,1]],
              [[0,2],[1,2],[2,2]],
              [[0,0],[1,1],[2,2]],
              [[0,2],[1,1],[2,0]]
            ]
    flag = true
    wincond.each {|arr|
      arr.each{|subarr|
        x = subarr[0]
        y = subarr[1]
        if @board.pattern[x][y] != mark
          flag = false
        end
      }
      if flag
        return true;
      end
      flag = true
    }
    return false
  end
end
