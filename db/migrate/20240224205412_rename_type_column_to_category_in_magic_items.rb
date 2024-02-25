class RenameTypeColumnToCategoryInMagicItems < ActiveRecord::Migration[7.1]
  def change
    rename_column :magic_items, :type, :category
  end
end
