class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.string :user_name
      t.string :email
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
