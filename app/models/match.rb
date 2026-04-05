class Match < ApplicationRecord
  belongs_to :player_a, class_name: "Player"
  belongs_to :player_b, class_name: "Player"

  belongs_to :winner, class_name: "Player"
  belongs_to :loser, class_name: "Player", optional: true

  before_validation :set_loser
  after_commit :update_player_stats, on: :create

  validate :players_must_be_different
  validate :winner_must_be_valid

  private

  def set_loser
    return unless winner_id.present? && player_a_id.present? && player_b_id.present?

    self.loser_id =
      if winner_id == player_a_id
        player_b_id
      elsif winner_id == player_b_id
        player_a_id
      end
  end

  def update_player_stats
    return unless winner.present? && loser.present?

    ActiveRecord::Base.transaction do
      winner.increment!(:wins)
      loser.increment!(:losses)
    end
  end

  def players_must_be_different
    if player_a_id.present? && player_b_id.present? && player_a_id == player_b_id
      errors.add(:base, "Players must be different")
    end
  end

  def winner_must_be_valid
    return unless winner_id.present?

    unless [player_a_id, player_b_id].include?(winner_id)
      errors.add(:winner, "must be one of the players")
    end
  end
end