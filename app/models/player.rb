class Player < ApplicationRecord
  has_secure_password

  has_many :dm_parties, class_name: 'Party', foreign_key: 'dm_player_id'

  has_many :characters

  validates :user_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
end
