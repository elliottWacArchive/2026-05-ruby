class Step < ApplicationRecord
  belongs_to :quest
  has_one :riddle, dependent: :destroy
  has_one :npc, dependent: :destroy

  validates :position, presence: true, numericality: { greater_than: 0 }
  validates :experience_reward, numericality: { greater_than_or_equal_to: 0 }

  accepts_nested_attributes_for :riddle, allow_destroy: true
  accepts_nested_attributes_for :npc, allow_destroy: true
end
