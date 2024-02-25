class MagicItem < ApplicationRecord
    has_many :character_magic_items
    has_many :characters, through: :character_magic_items

    validates :name, presence: true
    validates :category, presence: true
    validates :desc, presence: true
    validates :rarity, presence: true
    validates :requires_attunement, inclusion: { in: [true, false] }
end
