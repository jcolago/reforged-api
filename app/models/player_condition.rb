class PlayerCondition < ApplicationRecord
  belongs_to :player
  belongs_to :condition

  validates :condition_length, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :player_id, presence: true
  validates :condition_id, presence: true
  validate :unique_player_condition_combination

  private

  def unique_player_condition_combination
    if PlayerCondition.where(player_id: player_id, condition_id: condition_id).exists?
      errors.add(:base, "This player already has this condition")
    end
  end
end
