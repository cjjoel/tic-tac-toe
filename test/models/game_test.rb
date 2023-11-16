# frozen_string_literal: true

require "test_helper"

class GameTest < ActiveSupport::TestCase
  def setup
    @game = Game.new({ player: Constants::X, player_turn: Constants::FIRST_TURN })
  end

  def test_should_not_be_valid_without_player_turn
    game = Game.new({ player: Constants::X })
    assert_not game.valid?
  end

  def test_should_not_be_valid_without_player_character
    game = Game.new({ player_turn: Constants::FIRST_TURN })
    assert_not game.valid?
  end

  def test_should_return_true_for_draw
    @game.board[0] = @game.board[5] = @game.board[6] = @game.board[7] = Constants::O
    @game.board[1] = @game.board[2] = @game.board[3] = @game.board[4] = @game.board[8] = Constants::O
    assert @game.draw?
  end

  def test_should_return_true_for_win
    @game.board[0] = @game.board[1] = @game.board[2] = Constants::O
    assert @game.wins?(Constants::O)
  end

  def test_should_make_player_move
    @game.make_player_move(3)
    assert_equal Constants::X, @game.board[3]
  end

  def test_should_make_perfect_computer_move
    @game.board[0] = Constants::O
    @game.board[1] = @game.board[4] = Constants::X
    @game.make_computer_move
    assert_equal Constants::O, @game.board[7]
  end
end
