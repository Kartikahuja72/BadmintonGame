class CreateMatches < ActiveRecord::Migration[8.0]
  def change
    create_table :matches do |t|
      t.bigint :player_a_id
      t.bigint :player_b_id
      t.bigint :winner_id
      t.bigint :loser_id

      t.timestamps
    end
    add_foreign_key :matches, :players, column: :player_a_id
    add_foreign_key :matches, :players, column: :player_b_id
    add_foreign_key :matches, :players, column: :winner_id
    add_foreign_key :matches, :players, column: :loser_id
  end
end
