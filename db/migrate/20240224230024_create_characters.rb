class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :char_class
      t.integer :level
      t.references :player, null: false, foreign_key: true
      t.references :party, foreign_key: true
      t.references :magic_item, foreign_key: true
      t.references :mundane_item, foreign_key: true

      t.timestamps
    end
  end
end
