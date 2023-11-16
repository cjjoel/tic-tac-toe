# frozen_string_literal: true

require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  def test_should_render_game_form
    get new_game_path
    assert_response :success
  end

  def test_should_create_game_with_valid_params
    post game_path, params: game_params
    assert_response :success
  end

  def test_should_not_create_game_without_player_param
    post game_path, params: { game: { player_turn: Constants::FIRST_TURN } }
    assert_response :unprocessable_entity
  end

  def test_should_not_create_game_without_player_turn_param
    post game_path, params: { game: { player: Constants::X } }
    assert_response :unprocessable_entity
  end

  def test_should_update_game_board
    post game_path, params: game_params
    patch game_path, params: { game: { position: 0 } }, as: :turbo_stream
    assert_response :success
  end

  private

    def game_params
      { game: { player: Constants::X, player_turn: Constants::FIRST_TURN } }
    end
end
