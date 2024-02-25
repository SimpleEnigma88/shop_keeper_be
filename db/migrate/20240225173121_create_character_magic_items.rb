class CreateCharacterMagicItems < ActiveRecord::Migration[7.1]
  def change
    create_table :character_magic_items do |t|
      t.references :character, null: false, foreign_key: true
      t.references :magic_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
