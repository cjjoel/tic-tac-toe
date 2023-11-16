# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :reset_session, only: :new
  before_action :load_game_data, only: :update
  after_action :store_game_data, only: %i[create update]

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    unless @game.valid?
      render status: :unprocessable_entity, json: { error: @game.errors.full_messages.to_sentence }
    end
    @game.make_computer_move if game_params[:player_turn] == Constants::SECOND_TURN
  end

  def update
    @game.make_player_move(game_params[:position])
    @game.make_computer_move
  end

  private

    def game_params
      params.require(:game).permit(:player, :player_turn, :position)
    end

    def store_game_data
      session[:game] = Marshal.dump(@game)
    end

    def load_game_data
      @game = Marshal.load(session[:game])
    end
end
