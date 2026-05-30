class AuctionListing < ApplicationRecord
  belongs_to :inventory
  belongs_to :seller, class_name: "Character"
  belongs_to :buyer, class_name: "Character", optional: true

  validates :price, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: %w[active sold cancelled] }

  delegate :item, to: :inventory

  scope :active, -> { where(status: "active") }

  def buy!(buyer_character)
    return false if buyer_character == seller
    return false if buyer_character.gold < price

    ActiveRecord::Base.transaction do
      buyer_character.update!(gold: buyer_character.gold - price)
      seller.update!(gold: seller.gold + price)

      # transfert de l'inventaire
      inventory.update!(character: buyer_character, equipped: false)

      update!(status: "sold", buyer: buyer_character)
    end
    true
  end
end
