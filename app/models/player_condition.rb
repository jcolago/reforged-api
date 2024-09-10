class PlayerCondition < ApplicationRecord
  belongs_to :player
  belongs_to :condition

  validates :condition_length, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :player_id, presence: true
  validates :condition_id, presence: true
  validate :unique_player_condition_combination

  private

  def unique_player_condition_combination
    existing_condition = PlayerCondition.where(player_id: player_id, condition_id: condition_id)
    existing_condition = existing_condition.where.not(id: id) if persisted?
    if existing_condition.exists?
      errors.add(:base, "This player already has this condition")
    end
  end
end
