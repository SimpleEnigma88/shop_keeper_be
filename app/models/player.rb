class Player < ApplicationRecord
    has_many :dm_parties, class_name: 'Party', foreign_key: 'dm_player_id'

    has_many :characters, dependent: :destroy
end
