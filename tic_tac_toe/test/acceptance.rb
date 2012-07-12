require "minitest/autorun"

describe "A tic tac toe game" do
  let(:game) do
    game = Object.new

    def game.messages
      @messages ||= ["It's your turn, X", "It's your turn, O"]
    end

    def game.message
      messages.shift
    end

    def game.move(position)
    end

    game
  end

  it "starts with a move by X" do
    game.message.must_equal("It's your turn, X")
    game.move(5)
    game.message.must_equal("It's your turn, O")
  end
end
