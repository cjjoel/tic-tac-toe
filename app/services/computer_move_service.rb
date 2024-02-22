# frozen_string_literal: true

class ComputerMoveService
  def initialize(game, computer)
    @game = game
    @computer = computer
  end

  def process
    opponent, worst_score, extremum = Constants::PLAYER_DETAILS[@computer].values
    0.upto(Constants::BOARD_SIZE - 1).reduce([worst_score, 0]) do |best_position, index|
      next best_position if @game.board[index]

      @game.board[index] = @computer
      score = minimax(opponent)
      @game.board[index] = nil
      [[score, index], best_position].method(extremum).call(&:first)
    end.second
  end

  private

    def minimax(player)
      return 10 if @game.wins?(Constants::O)
      return -10 if @game.wins?(Constants::X)
      return 0 if @game.draw?

      opponent, worst_score, extremum = Constants::PLAYER_DETAILS[player].values
      0.upto(Constants::BOARD_SIZE - 1).reduce(worst_score) do |best_score, index|
        next best_score if @game.board[index]

        @game.board[index] = player
        score = minimax(opponent)
        @game.board[index] = nil
        [score, best_score].method(extremum).call(&:itself)
      end
    end
end
