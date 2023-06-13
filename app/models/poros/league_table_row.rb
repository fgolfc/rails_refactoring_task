module Poros
  class LeagueTableRow
    attr_accessor :club, :rank, :year, :matches

    def initialize(club, year)
      @club = club
      @year = year
      @rank = nil
      @matches = club.matches_on(year)
    end

    def prepare_row
      self
    end

    def digested_games_count
      @digested_games_count ||= @matches.where(kicked_off_at: Date.new(year, 1, 1)...Time.current).count
    end

    def win
      @win ||= club.win_on(year)
    end

    def lost
      @lost ||= club.lost_on(year)
    end

    def draw
      @draw ||= club.draw_on(year)
    end

    def goals
      @goals ||= matches.sum {|match| match.goal_by(club) }
    end

    def goals_conceded
      @goals_conceded ||= matches.sum {|match| match.goal_conceded_by(club) }
    end

    def goal_difference
      @goal_difference ||= goals - goals_conceded
    end

    def points
      @points ||= win * League::WIN_POINTS + draw * League::DRAW_POINTS
    end
  end
end
