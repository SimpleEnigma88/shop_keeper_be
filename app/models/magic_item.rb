class MagicItem < ApplicationRecord
    belongs_to :character, optional: true
end
