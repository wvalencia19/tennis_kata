# frozen_string_literal: true

module TennisScores
  DEFAULTS = {
    0 => 'Love',
    1 => 'Fifteen',
    2 => 'Thirty',
    3 => 'Forty'
  }.freeze

  TIED = {
    0 => 'Love-All',
    1 => 'Fifteen-All',
    2 => 'Thirty-All'
  }.freeze

  ADVANTAGE = 'Advantage %<player_name>s'
  WINNER = 'Win for %<player_name>s'
end

class Player
  include TennisScores

  attr_reader(:name, :points)

  def initialize(name)
    @name = name
    @points = 0
  end

  def won_point
    @points += 1
  end

  def score
    DEFAULTS[@points]
  end
end

class TennisGame
  include TennisScores

  def initialize(player1_name, player2_name)
    @player1 = Player.new(player1_name)
    @player2 = Player.new(player2_name)
  end

  def won_point(player_name)
    @player1.name == player_name ? @player1.won_point : @player2.won_point
  end

  def score
    return tie_score(@player1.points) if tie?
    return ongoing_score if ongoing?

    advantage_or_finished
  end

  private

  def ongoing?
    @player1.points < 4 && @player2.points < 4
  end

  def ongoing_score
    "#{@player1.score}-#{@player2.score}"
  end

  def tie?
    @player1.points == @player2.points
  end

  def tie_score(points)
    TIED.fetch(points, 'Deuce')
  end

  def advantage_or_finished
    minus_result = @player1.points - @player2.points
    if minus_result == 1
      format(ADVANTAGE, player_name: @player1.name)
    elsif minus_result == -1
      format(ADVANTAGE, player_name: @player2.name)
    elsif minus_result >= 2
      format(WINNER, player_name: @player1.name)
    else
      format(WINNER, player_name: @player2.name)
    end
  end
end
