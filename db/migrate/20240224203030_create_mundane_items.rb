class CreateMundaneItems < ActiveRecord::Migration[7.1]
  def change
    create_table :mundane_items do |t|
      t.string :name
      t.integer :value
      t.text :description

      t.timestamps
    end
  end
end
