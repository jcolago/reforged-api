class Monster < ApplicationRecord
  belongs_to :games

  validates :name, presence: true
  validates :size, :alignment, :armor_class, :hit_points, :speed, :p_bonus, presence: true, numericality: { only_integer: true }
  validates :resistances, :attacks, presence: true
  validates :displayed, inclusion: { in: [ true, false ] }

  # enums for size and alignment
  enum size: { tiny: 0, small: 1, medium: 2, large: 3, huge: 4, gargantuan: 5 }
  enum alignmanet: { lawful_good: 0, neutral_good: 1, chaotic_good: 2, lawful_neutral: 3, true_neutral: 4, chaotic_neutral: 5, lawful_evil: 6, neutral_evil: 7, chaotic_evil: 8 }
end
