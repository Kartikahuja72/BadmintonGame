class AddPhoneToPlayers < ActiveRecord::Migration[8.0]
  def change
    add_column :players, :phone, :string
    add_index :players, :phone, unique: true
  end
end
