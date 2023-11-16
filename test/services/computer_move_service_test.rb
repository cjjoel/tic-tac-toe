# frozen_string_literal: true

require "test_helper"

class ComputerMoveServiceTest < ActiveSupport::TestCase
  def setup
    @player = Constants::X
    @computer = Constants::O
    @game = Game.new({ player: @player, player_turn: Constants::FIRST_TURN })
  end

  def test_should_return_perfect_move
    @game.board[0] = Constants::O
    @game.board[1] = @game.board[4] = Constants::X
    computer_move_service = ComputerMoveService.new(@game, @computer, @player)
    move = computer_move_service.process
    assert_equal 7, move
  end
end
