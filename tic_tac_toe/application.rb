require "ray"

class TicTacToe
  def initialize
    @players = [:X, :O].cycle
    start_new_turn
  end

  attr_reader :message

  def start_new_turn
    @message = "It's your turn, #{@players.next}"
  end
end

class TicTacToe
  class UI < Ray::Game
    def initialize
      super("Tic Tac Toe")

      MainScene.bind(self)
      push_scene :main
    end

    def register
      add_hook :quit, method(:exit!)
    end
    
    class MainScene < Ray::Scene
      scene_name :main

      def setup
        @game = TicTacToe.new
      end

      def message
        @game.message
      end

      def register
        on :text_entered do |char|
          @game.start_new_turn
        end
      end
      
      def render(win)
        win.draw(text(@game.message, :size => 24, :at => [450,425]))
      end
    end
  end
end
=begin
if __FILE__ == $PROGRAM_NAME
  TicTacToe::UI.new.run
end
=end
