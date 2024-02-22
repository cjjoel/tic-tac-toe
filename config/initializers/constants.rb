# frozen_string_literal: true

module Constants
  O = "O"
  X = "X"
  BOARD_SIZE = 9
  FIRST_TURN = "1"
  SECOND_TURN = "2"
  PLAYER_DETAILS = {
    Constants::X => {
      opponent: Constants::O,
      worst_score: Float::INFINITY,
      extremum: :min_by
    },
    Constants::O => {
      opponent: Constants::X,
      worst_score: -Float::INFINITY,
      extremum: :max_by
    }
  }
end
