class RemoveItemIdsFromCharacters < ActiveRecord::Migration[7.1]
  def change
    remove_column :characters, :magic_item_id, :integer
    remove_column :characters, :mundane_item_id, :integer
  end
end
