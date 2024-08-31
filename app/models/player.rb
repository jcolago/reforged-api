class Player < ApplicationRecord
  belongs_to :game

  validates :name, :character, presence: true
  validates :level, :current_hp, :total_hp, :armor_class, :speed, :initiative_bonus, :strength, :str_save, :dexterity, :dex_save, :constitution, :con_save, :intelligence, :int_save, :wisdom, :wis_save,  :charisma, :cha_save, presence: true, numericality: { only_integer: true }
  validates :displayed, inclusion: { in: [ true, false ] }
  validates :game_id, presence: true

  has_many :player_conditions
  has_many :conditions, through: :player_conditions

  validate :current_hp_not_exceeding_total_hp

  before_save :calculate_ability_bonuses

  ABILITY_SCORES = [ :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma ]

  private

  def current_hp_not_exceeding_total_hp
    if current_hp > total_hp
      errors.add(:current_hp, "can't exceed total HP")
    end
  end

  def calculate_ability_bonuses
    ABILITY_SCORES.each do |ability|
      score = send(ability)
      bonus = calculate_bonus(score)
      send("#{ability.to_s[0..2]}_bonus=", bonus)
    end
  end

  def calculate_bonus(score)
    (score - 10) / 2
  end
end
