class Character < ApplicationRecord
  belongs_to :player, optional: false
  belongs_to :party, optional: true

  has_many :magic_item
  has_many :mundane_item
end
