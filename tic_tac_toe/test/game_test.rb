require "minitest/autorun"
require_relative "../lib/tic_tac_toe"

describe TicTacToe::Game do
  let(:game) { TicTacToe::Game.new }

  it "should alternate players on a successful move" do
    game.current_player.must_equal(:X)
    game.move(5) 

    game.current_player.must_equal(:O)
    game.move(3)

    game.current_player.must_equal(:X)
  end

  it "should not alternate players on an invalid move" do
    game = TicTacToe::Game.new

    game.current_player.must_equal(:X)
    game.move(5)

    game.current_player.must_equal(:O)
    game.move(5)

    game.current_player.must_equal(:O)
  end

  it "should yield the player that moved on a successful move" do
    current_player = nil

    game.move(5) { |player| current_player = player }

    current_player.must_equal(:X)

    game.move(3) { |player| current_player = player }
    
    current_player.must_equal(:O)
  end

  it "should not yield the player that moved on an unsuccessful move" do
    current_player = nil

    called = []

    game.move("Foo") { called << :illegal }
    game.move(5)     { called << :legal }
    game.move(5)     { called << :illegal }

    called.must_equal [:legal]
  end
end
