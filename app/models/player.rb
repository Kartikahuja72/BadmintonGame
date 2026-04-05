class Player < ApplicationRecord

  validates :name, presence: true
  validates :phone, presence: true, uniqueness: true
  has_many :matches_as_player_a, class_name: "Match", foreign_key: :player_a_id, dependent: :destroy
  has_many :matches_as_player_b, class_name: "Match", foreign_key: :player_b_id, dependent: :destroy
end
