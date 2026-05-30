class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :characters, dependent: :destroy

  ROLES = %w[player game_master].freeze

  validates :role, inclusion: { in: ROLES }
  validates :username, presence: true, uniqueness: true, length: { minimum: 2, maximum: 30 }

  def game_master?
    role == "game_master"
  end

  def player?
    role == "player"
  end
end
