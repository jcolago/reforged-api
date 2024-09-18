class User < ApplicationRecord
  has_many :games, foreign_key: "dm_id"
  has_many :sessions, dependent: :destroy
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password,
            presence: true,
            length: { minimum: 6 },
            if: :password_digest_changed?
end
