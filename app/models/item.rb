class Item < ApplicationRecord
  has_many :inventories, dependent: :destroy
  has_one_attached :image

  SLOTS = %w[hat weapon shield].freeze

  validates :name, presence: true
  validates :slot, inclusion: { in: SLOTS }
  validates :xp_multiplier, numericality: { greater_than: 0 }

  def slot_label
    { "hat" => "Chapeau", "weapon" => "Arme", "shield" => "Bouclier" }[slot]
  end
end
