class Monster < ApplicationRecord
  belongs_to :game

  validates :name, presence: true
  validates :armor_class, :hit_points, :speed, :p_bonus, presence: true, numericality: { only_integer: true }
  validates :resistances, :attacks, presence: true
  validates :displayed, inclusion: { in: [ true, false ] }

  # enums for size and alignment
  enum :size, [
    :tiny,
    :small,
    :medium,
    :large,
    :huge,
    :gargantuan
  ]

  enum :alignment, [
    :lawful_good,
    :neutral_good,
    :chaotic_good,
    :lawful_neutral,
    :true_neutral,
    :chaotic_neutral,
    :lawful_evil,
    :neutral_evil,
    :chaotic_evil
  ]
end
