class MatchesController < BaseController

  before_action :validate_players_presence_and_existence, only: [:create]
  
  def create
    match = Match.new(match_params)
    match.created_by_id = @current_user.id

    if match.save
      render json: match, status: :created
    else
      render json: { errors: match.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def match_params
    params.require(:match).permit(:player_a_id, :player_b_id, :winner_id)
  end

  def validate_players_presence_and_existence
    pa = params.dig(:match, :player_a_id)
    pb = params.dig(:match, :player_b_id)
    winner = params.dig(:match, :winner_id)

    if pa.blank? || pb.blank? || winner.blank?
      return render json: { error: "player_a_id, player_b_id and winner_id are required" }, status: :unprocessable_entity
    end

    unless Player.exists?(pa)
      return render json: { error: "player_a_id is invalid" }, status: :unprocessable_entity
    end

    unless Player.exists?(pb)
      return render json: { error: "player_b_id is invalid" }, status: :unprocessable_entity
    end

    unless Player.exists?(winner)
      return render json: { error: "winner_id is invalid" }, status: :unprocessable_entity
    end
  end
end