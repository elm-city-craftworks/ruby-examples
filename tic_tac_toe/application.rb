require "ray"

require_relative "lib/tic_tac_toe"

module TicTacToe
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

      attr_reader :message

      def setup
        @game = TicTacToe::Game.new
        update_message
      end

      def register
        on :text_entered do |char|
          input = Ray::TextHelper.convert(char).to_i

          if (1..9).include?(input)
            @game.move(input)
            update_message
          end
        end
      end
 
      def render(win)
        win.draw(text(message, :size => 24, :at => [450,425]))
      end

      def update_message
        @message = "It's your turn, #{@game.current_player}"
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  TicTacToe::UI.new.run
end
