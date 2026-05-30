class Inventory < ApplicationRecord
  belongs_to :character
  belongs_to :item
  has_one :auction_listing, dependent: :destroy

  # un seul objet par slot peut être équipé
  before_save :unequip_same_slot, if: -> { equipped? && equipped_changed? }

  private

  def unequip_same_slot
    character.inventories
             .joins(:item)
             .where(equipped: true, items: { slot: item.slot })
             .where.not(id: id)
             .update_all(equipped: false)
  end
end
