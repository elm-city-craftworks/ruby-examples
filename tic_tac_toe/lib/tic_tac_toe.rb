module TicTacToe
  class Game
    def initialize
      self.players = [:X, :O].cycle
    end

    def move(pos)
      players.next
    end

    def current_player
      players.peek
    end

    private

    attr_accessor :players
  end
end
