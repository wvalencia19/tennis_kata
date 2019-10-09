class TennisGame

  attr_reader :p1points, :p2points

  TIE_RESULTS = %w[Love-All Fifteen-All Thirty-All].freeze
  RESULTS = %w[Love Fifteen Thirty Forty].freeze

  def initialize(player1_name, player2_name)
    @player1_name = player1_name
    @player2_name = player2_name
    @p1points = 0
    @p2points = 0
  end

  def won_point(player_name)
    return @p1points += 1 if player_name == 'player1'

    @p2points += 1
  end

  def score
    return tie_result if tie?
    return advantage_or_win_result if advantage_or_win?

    intermediate_result
  end


  private
  def tie?
    p1points == p2points
  end

  def advantage_or_win?
    p1points > 3 || p2points > 3
  end

  def tie_result
    TIE_RESULTS.fetch(p1points, 'Deuce')
  end

  def advantage_or_win_result
    minus_result = p1points - p2points

    if minus_result == 1
      'Advantage player1'
    elsif minus_result == -1
      'Advantage player2'
    elsif minus_result >= 2
      'Win for player1'
    else
      'Win for player2'
    end
  end

  def intermediate_result
    "#{RESULTS[p1points]}-#{RESULTS[p2points]}"
  end
end
