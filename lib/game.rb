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
    class Board
      attr_accessor :pattern
      attr_reader :available
      def initialize
        @pattern = [
                    ["*", "*", "*"],
                    ["*", "*", "*"],
                    ["*", "*", "*"]
                  ]
        @available = (1..9).to_a
      end

      def display
        # Display the present board in a nicely formatted manner
        print("\n\n")

        puts "        SELECT                                             BOARD\n\n"

        count = 0
        @pattern.each_with_index{|row, i|
          if @pattern[i][0] == "*" then print "#{i+count+1}    |    " else print "     |    " end
          if @pattern[i][1] == "*" then print "#{i+count+2}    |    " else print "     |    " end
          if @pattern[i][2] == "*" then print "#{i+count+3}" else print " " end
          print "                              "
          count += 2
          row.each_with_index{|col, j|
            print col
            print "    |    " if j < 2
          }
          puts "\n-----+---------+--------                        --------+---------+--------" if i < 2
        }
          puts "\n"
      end

      def full?
        # Use this to determine if all the positions have been played
        @available.count == 0
      end

    end

  class Player
    attr_reader :mark
    def initialize(name, mark, board)
      @name = name
      @mark = mark
      @board = board
    end

    def play
      print "#{@name} Play: "
      position = gets.chomp.to_i
      while !@board.available.include?(position)
        puts "Sorry!! You cannot place a mark at #{position}. Position #{position} is either marked or not available"
        print "#{@name} Play Again: "
        position = gets.chomp.to_i
      end
      @board.pattern[(position-1)/3][(position-1)%3] = @mark
      @board.available.delete(position)
    end
  end

  def settings
    print "Enter " + "Player 1".blue + " Game mark: "
    mark_1 = gets.chomp.blue
    print "Enter " + "Player 2".green + " Game mark: "
    mark_2 = gets.chomp.green
    @player_1 = Player.new("Player 1".blue, mark_1, @board)
    @player_2 = Player.new("Player 2".green, mark_2, @board)
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
