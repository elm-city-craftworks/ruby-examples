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
        @game       = TicTacToe::Game.new
        @grid       = Grid.new

        update_message
      end

      def register
        on :text_entered do |char|
          input = Ray::TextHelper.convert(char).to_i

          if (1..9).include?(input)
            @game.move(input) do |player|
              @grid.update(input, player.to_s)
            end

            update_message
          end
        end
      end
 
      def render(win)
        win.draw(text(message, :size => 24, :at => [450,425]))

        @grid.draw(win)
      end

      def update_message
        case @game.status
        when :playing
          @message = "It's your turn, #{@game.current_player}"
        when :draw
          @message = "It's a draw"
        when :won_by_x
          @message = "X won"
        when :won_by_o
          @message = "O won"
        end
      end
    end

    class Grid
      def initialize
        counter = 0

        @drawables = [0,1,2].product([0,1,2]).map do |y,x|
          counter += 1
          Box.new([100 + x*100, 100 + y*100], counter.to_s)
        end
      end

      def update(position, name)
        box = @drawables[position - 1]

        box.name =  name
        box.shape.color = Ray::Color.blue
      end

      def draw(win)
        @drawables.each { |drawable| drawable.draw(win) }
      end
    end

    class Box
      def initialize(offset, name)
        @offset = offset
        @shape    = Ray::Polygon.rectangle([0, 0, 80, 80], Ray::Color.red) 
        @shape.pos += offset

        @name = name
      end

      attr_accessor :name
      attr_reader   :shape

      def draw(win)
        win.draw(@shape)
        win.draw(Ray::Text.new(name, :size => 64, 
                                     :at => @shape.pos + [25, -5], 
                                     :font => "ibm.ttf"))
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  TicTacToe::UI.new.run
end
