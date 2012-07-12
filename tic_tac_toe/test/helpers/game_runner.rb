require_relative "../../application"

class GameRunner
  def self.run
    runner = new
    runner.setup

    yield(runner)

    runner.teardown
  end

  def initialize
    @interface = TicTacToe::UI.new
    @scene     = @interface.registered_scene(:main)
  end

  def setup
    @scene.register
    @scene.setup
  end

  def move(number)
    @scene.raise_event :text_entered, number.to_s
    @interface.event_runner.run
  end

  def message
    @scene.message
  end

  def teardown
    @scene.clean_up
  end
end
