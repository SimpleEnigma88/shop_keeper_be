class Character < ApplicationRecord
  belongs_to :player, optional: false
  belongs_to :party, optional: true

  has_many :character_magic_items
  has_many :magic_items, through: :character_magic_items

  validates :name, presence: true
  validates :char_class, presence: true
  validates :level, presence: true
end
