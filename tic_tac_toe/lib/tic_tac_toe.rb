module TicTacToe
  class Game
    def initialize
      self.players = [:X, :O].cycle
      self.moves   = Hash.new { |h,k| h[k] = [] }
    end

    def move(pos)
      return if moves.any? { |k,v| v.include?(pos) }

      moves[current_player] << pos
      
      players.next
    end

    def current_player
      players.peek
    end

    private

    attr_accessor :players, :moves
  end
end
