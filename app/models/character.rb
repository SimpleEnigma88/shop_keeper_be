class Character < ApplicationRecord
  belongs_to :player, optional: false
  belongs_to :party, optional: true

  has_many :character_magic_items
  has_many :magic_items, through: :character_magic_items, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :player_id, message: "has already been taken" }
  validates :char_class, presence: true
  validates :level, presence: true
end
