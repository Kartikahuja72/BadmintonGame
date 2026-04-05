class StatsController < BaseController
  def leaderboard
    players = Player.order(wins: :desc, losses: :asc)

    ranked_players = players.each_with_index.map do |player, index|
      {
        rank: index + 1,
        id: player.id,
        name: player.name,
        phone: player.phone,
        wins: player.wins,
        losses: player.losses,
        win_percentage: calculate_percentage(player)
      }
    end

    render json: {
      total_players: players.count,
      leaderboard: ranked_players
    }, status: :ok
  end

  def match_results
    matches = Match.includes(:player_a, :player_b, :winner, :loser).order(created_at: :desc)

    results = matches.map do |match|
      {
        id: match.id,
        player_a: match.player_a.name,
        player_b: match.player_b.name,
        player_a_id: match.player_a_id,
        player_b_id: match.player_b_id,
        winner: match.winner.name,
        loser: match.loser&.name,
        played_at: match.created_at.strftime("%d %b %Y %I:%M %p")
      }
    end

    render json: { matches: results }, status: :ok
  end

  private

  def calculate_percentage(player)
    total = player.wins + player.losses
    return 0 if total == 0

    ((player.wins.to_f / total) * 100).round(2)
  end
end