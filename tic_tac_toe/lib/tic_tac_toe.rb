module TicTacToe
  class Game
    LINES = [[1,2,3], [4,5,6], [7,8,9], # horizontal
             [1,4,7], [2,5,8], [3,6,9], # vertical
             [1,5,9], [3,5,7]]          # diagonal

    def initialize
      self.players = [:X, :O].cycle
      self.moves   = Hash.new { |h,k| h[k] = [] }
      self.status  = :playing
    end

    attr_reader :status

    def move(pos) 
      return unless status == :playing
      return unless (1..9).include?(pos) && moves.none? { |k,v| v.include?(pos) }

      moves[current_player] << pos

      yield(current_player) if block_given?
      
      update_status
      players.next
    end

    def current_player
      players.peek
    end

    private

    def update_status
      if LINES.any? { |line| (line - moves[current_player]).empty? }
        self.status = current_player == :X ? :won_by_x : :won_by_o
      elsif moves[:X].count + moves[:O].count == 9
        self.status = :draw
      end
    end


    attr_accessor :players, :moves
    attr_writer   :status
  end
end
