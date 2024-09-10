class Game < ApplicationRecord
  belongs_to :dm, class_name: "User", foreign_key: "dm_id"
  has_many :monsters, dependent: :destroy

  validates :name, presence: true
end
