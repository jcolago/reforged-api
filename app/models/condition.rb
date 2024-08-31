class Condition < ApplicationRecord
  validates :name, presence: true
  has_many :player_conditions
  has_many :players, through: :player_conditions
end
