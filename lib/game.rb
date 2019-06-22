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

  def play(position)
    @board.pattern[(position-1)/3][(position-1)%3] = @mark
    @board.available.delete(position)
  end

  def check_win
    wincond=[
              [[0,0],[0,1],[0,2]], [[1,0],[1,1],[1,2]],
              [[2,0],[2,1],[2,2]], [[0,0],[1,0],[2,0]],
              [[0,1],[1,1],[2,1]], [[0,2],[1,2],[2,2]],
              [[0,0],[1,1],[2,2]], [[0,2],[1,1],[2,0]]
            ]
    flag = true
    wincond.each {|arr|
      arr.each{|subarr|
        x = subarr[0]
        y = subarr[1]
        if @board.pattern[x][y] != self.mark
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
