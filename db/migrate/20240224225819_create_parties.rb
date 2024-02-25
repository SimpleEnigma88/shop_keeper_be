class CreateParties < ActiveRecord::Migration[7.1]
  def change
    create_table :parties do |t|
      t.integer :dm_player_id

      t.timestamps
    end
    add_index :parties, :dm_player_id
    add_foreign_key :parties, :players, column: :dm_player_id
  end
end
