class AddCreatedByIdToMatches < ActiveRecord::Migration[8.0]
  def change
    add_column :matches, :created_by_id, :bigint
    add_index :matches, :created_by_id

    add_foreign_key :matches, :users, column: :created_by_id
  end
end
