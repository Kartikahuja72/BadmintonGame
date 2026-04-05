class PlayersController < BaseController

  before_action :set_player, only: [:update, :destroy]

  def index
    players = Player.all
    render json: players, status: :ok
  end

  def create
    player = Player.new(player_params)
    player.created_by_id = @current_user.id

    if player.save
      render json: player, status: :created
    else
      render json: { errors: player.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @player.update(player_params.merge(updated_by_id: @current_user.id))
      render json: @player, status: :ok
    else
      render json: { errors: @player.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @player.destroy
    render json: { message: "Player deleted successfully" }, status: :ok
  end

  private

  def set_player
    @player = Player.find_by(id: params[:id])

    unless @player
      render json: { error: "Player not found" }, status: :not_found
    end
  end

  def player_params
    params.require(:player).permit(:name, :phone)
  end
end