require File.expand_path('../lib/game.rb')
require 'colorize'

def get_play_position(name, board)
  print "#{name} Play: "
  position = gets.chomp.to_i
  while !board.available.include?(position)
    puts "Sorry!! You cannot place a mark at #{position}. Position #{position} is either marked or not available"
    print "#{name} Play Again: "
    position = gets.chomp.to_i
  end
  return position
end

def display_rules
  puts "==================================================Rules=============================================================="
  puts "2. When the game starts each player selects a position to mark. Positions range from 1 through 9 as indicated below"
  puts "2. The player who succeeds in placing three of their marks in a horizontal, vertical, or diagonal row wins the game"
  puts "3. When all the spaces on the board are exausted, the game draws" 
  puts "                         *** 'X' is mark for Player 1 ****  and *** 'O' is mark for Player 2                         " 
  puts "====================================================================================================================="
  
end

def display_board(board)
  # Display the present board in a nicely formatted manner
  print("\n\n")

  puts "        SELECT                                             BOARD\n\n"

  count = 0
  board.pattern.each_with_index{|row, i|
    if board.pattern[i][0] == "*" then print "#{i+count+1}    |    " else print "     |    " end
    if board.pattern[i][1] == "*" then print "#{i+count+2}    |    " else print "     |    " end
    if board.pattern[i][2] == "*" then print "#{i+count+3}" else print " " end
    print "                              "
    count += 2
    row.each_with_index{|col, j|
      print col
      print "    |    " if j < 2
    }
    puts "\n-----+---------+--------                        --------+---------+--------" if i < 2
  }
    puts "\n\n"
end

def main
  display_rules
  print "Press Enter to Start "
  gets.chomp()
  board = Board.new
  player_1 = Player.new("Player 1".blue, 'X'.blue, board)
  player_2 = Player.new("Player 2".green, 'O'.green, board)
  display_board(board)

  while true
    position = get_play_position("Player 1", board)
    player_1.play(position)
    display_board(board)
    if player_1.check_win
      puts "Player 1(#{player_1.mark}) won the game!"
      return
    end

    break if board.full?

    position = get_play_position("Player 2", board)
    player_2.play(position)
    display_board(board)
    if player_2.check_win
      puts "Player 2(#{player_2.mark}) won the game!"
      return
    end

    break if board.full?
  end 
  puts "No one won. The Game is a draw"
end

main
