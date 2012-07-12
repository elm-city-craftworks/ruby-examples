require "minitest/autorun"
require_relative "helpers/game_runner"

describe "A tic tac toe game" do
  it "alternates between X and O" do
    run_game do |runner|
      runner.message.must_equal("It's your turn, X")
      runner.move(5)
      runner.message.must_equal("It's your turn, O")
      runner.move(3)
      runner.message.must_equal("It's your turn, X")
    end
  end

  it "simply ignores illegal moves" do
    run_game do |runner|
      runner.message.must_equal("It's your turn, X")
      runner.move(5)
      runner.message.must_equal("It's your turn, O")
      runner.move(5)
      runner.message.must_equal("It's your turn, O")
    end
  end

  def run_game(&block)
    GameRunner.run(&block)
  end
end
