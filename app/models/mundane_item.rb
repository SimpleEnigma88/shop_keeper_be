class MundaneItem < ApplicationRecord
    belongs_to :character, optional: true
end
