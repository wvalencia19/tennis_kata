class TennisGame

  ADVANTAGE_SENTENCES = {
    0 => "Advantage player1",
    1 => "Advantage player2",
    2 => "Win for player1",
    3 => "Win for player2"
  }
  SCORE_WORDS = {
    0 => "Love",
    1 => "Fifteen",
    2 => "Thirty",
    3 => "Forty"
  }

  def initialize(player1Name, player2Name)
    @player1Name = player1Name
    @player2Name = player2Name
    @p1points = 0
    @p2points = 0
  end

  def won_point(playerName)
    if playerName == "player1"
      @p1points += 1
    else
      @p2points += 1
    end
  end

  def score
    return tie_sentence if tie?
    return advantage_sentence if advantage?
    score_sentence
  end

  def tie?
    @p1points == @p2points
  end

  def advantage?
    @p1points >= 4 or @p2points >= 4
  end

  def tie_sentence
    return "Deuce" if @p1points > 2

    "#{SCORE_WORDS[@p1points]}-All"
  end

  def advantage_sentence
    minusResult = @p1points-@p2points
      if (minusResult==1)
        "Advantage player1"
      elsif (minusResult ==-1)
        "Advantage player2"
      elsif (minusResult>=2)
        "Win for player1"
      else
        "Win for player2"
      end
  end

  def score_sentence
    "#{SCORE_WORDS[@p1points]}-#{SCORE_WORDS[@p2points]}"
  end
end
