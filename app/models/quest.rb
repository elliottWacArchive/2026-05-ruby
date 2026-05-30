class Quest < ApplicationRecord
  has_many :steps, -> { order(:position) }, dependent: :destroy
  has_many :quest_progresses, dependent: :destroy

  validates :name, presence: true
  validates :completion_xp, numericality: { greater_than: 0 }

  accepts_nested_attributes_for :steps, allow_destroy: true
end
