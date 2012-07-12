require "minitest/autorun"
require_relative "../application"

describe "A tic tac toe game" do
  before do
    @interface = TicTacToe::UI.new
    @scene     = @interface.registered_scene(:main)

    @scene.register
    @scene.setup
  end

  it "starts with a move by X" do
    @scene.message.must_equal("It's your turn, X")

    @scene.raise_event :text_entered, "5"
    @interface.event_runner.run

   @scene.message.must_equal("It's your turn, O")
  end

  after do 
    @scene.clean_up
  end
end
