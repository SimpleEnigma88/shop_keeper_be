class Party < ApplicationRecord
  belongs_to :dm_player, class_name: 'Player', foreign_key: 'dm_player_id', optional: false

  has_many :characters
  validates :name, presence: true, uniqueness: { scope: :dm_player_id, message: 'That name has already been taken' }
  validates :dm_player_id, presence: true
end
