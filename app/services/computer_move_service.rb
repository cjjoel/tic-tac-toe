# frozen_string_literal: true

class ComputerMoveService
  def initialize(game, computer, player)
    @game = game
    @computer = computer
    @player = player
  end

  def process
    best_score = @computer == Constants::O ? -Float::INFINITY : Float::INFINITY
    operator = @computer == Constants::O ? :< : :>
    0.upto(Constants::BOARD_SIZE - 1).reduce([best_score, 0]) do |best_position, index|
      next best_position if @game.board[index]

      @game.board[index] = @computer
      score = minimax(@player)
      @game.board[index] = nil
      should_update_score = best_position.first.method(operator).call(score)
      should_update_score ? [score, index] : best_position
    end.second
  end

  private

    def minimax(player)
      return 10 if @game.wins?(Constants::O)
      return -10 if @game.wins?(Constants::X)
      return 0 if @game.draw?

      if player == Constants::O
        return 0.upto(Constants::BOARD_SIZE - 1).reduce(-Float::INFINITY) do |max_score, index|
          next max_score if @game.board[index]

          @game.board[index] = Constants::O
          score = minimax(Constants::X)
          @game.board[index] = nil
          [max_score, score].max
        end
      end

      if player == Constants::X
        0.upto(Constants::BOARD_SIZE - 1).reduce(Float::INFINITY) do |min_score, index|
          next min_score if @game.board[index]

          @game.board[index] = Constants::X
          score = minimax(Constants::O)
          @game.board[index] = nil
          [min_score, score].min
        end
      end
    end
end
