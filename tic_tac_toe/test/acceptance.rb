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
  
  it "can end a game as a draw" do
    run_game do |runner|
      [1,2,3,5,4,6,8,7,9].each { |i| runner.move(i) }
      # 1 2 3                          X O X
      # 4 5 6 -> 1,2,3,5,4,6,8,7,9 ->  X O O
      # 7 8 9                          O X X
      
      runner.message.must_equal("It's a draw")
    end
  end

  it "can end game with a win by X in 9 moves" do
    run_game do |runner|
      [1,2,3,4,5,6,8,7,9].each { |i| runner.move(i) }
      # 1 2 3                          X O X
      # 4 5 6 -> 1,2,3,4,5,6,8,7,9 ->  O X O
      # 7 8 9                          O X X
      
      runner.message.must_equal("X won")
    end
  end

  it "can end game with a win by X in less than 9 moves" do
    run_game do |runner|
      [1,2,3,4,5,6,7].each { |i| runner.move(i) }
      # 1 2 3                          X O X
      # 4 5 6 -> 1,2,3,4,5,6,7     ->  O X O
      # 7 8 9                          X - -
 
      runner.message.must_equal("X won")
    end
  end

  it "can end game with a win by O in less than 9 moves" do
    run_game do |runner|
     [1,5,2,3,4,7].each { |i| runner.move(i) }
      # 1 3 2                          X X O
      # 4 5 6 -> 1,2,3,4,5,6,8,7,9 ->  X O -
      # 7 8 9                          O - -  
      runner.message.must_equal("O won")
    end
  end

  def run_game(&block)
    GameRunner.run(&block)
  end
end
