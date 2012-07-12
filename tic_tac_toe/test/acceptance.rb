require "minitest/autorun"
require_relative "helpers/game_runner"

describe "A tic tac toe game" do
  it "starts with a move by X" do
    GameRunner.run do |runner|
      runner.message.must_equal("It's your turn, X")
      runner.move(5)
      runner.message.must_equal("It's your turn, O")
    end
  end
end
