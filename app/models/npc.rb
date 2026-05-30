class Npc < ApplicationRecord
  belongs_to :step
  has_one_attached :avatar
  has_many :messages, dependent: :destroy
  has_many :combat_sessions, dependent: :destroy

  validates :name, presence: true
  validates :hp, :strength, numericality: { greater_than: 0 }
end
