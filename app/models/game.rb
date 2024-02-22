# frozen_string_literal: true

class Game
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_accessor :player, :player_turn, :board, :moves, :computer, :winner

  validates_presence_of :player, :player_turn

  def initialize(attributes = {})
    @player = attributes[:player]
    @player_turn = attributes[:player_turn]
    @computer = Constants::PLAYER_DETAILS[@player]&.[](:opponent)
    @board = Array.new(Constants::BOARD_SIZE)
    @moves = {}
    @winner = nil
  end

  def make_player_move(position)
    if @winner || draw?
      @moves = {}
    else
      @board[position.to_i] = @player
      @moves[:player] = {
        character: @player,
        cell_id: "cell_#{position}"
      }
      @winner = @player if wins?(@player)
    end
  end

  def make_computer_move
    if @winner || draw?
      @moves = {}
    else
      position = ComputerMoveService.new(self, @computer).process
      @board[position] = @computer
      moves[:computer] = {
        character: @computer,
        cell_id: "cell_#{position}"
      }
      @winner = @computer if wins?(@computer)
    end
  end

  def draw?
    @board.compact.size == Constants::BOARD_SIZE
  end

  def wins?(character)
    [
      # horizontal wins
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],

      # vertical wins
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],

      # diagonal wins
      [0, 4, 8],
      [6, 4, 2]
    ].any? do |positions|
      @board[positions[0]] == character &&
      @board[positions[0]] == @board[positions[1]] &&
      @board[positions[1]] == @board[positions[2]]
    end
  end
end
