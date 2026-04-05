class AddUpdatedByToPlayers < ActiveRecord::Migration[8.0]
  def change
    add_reference :players, :updated_by, foreign_key: { to_table: :users }
  end
end
