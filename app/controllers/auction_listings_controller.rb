class AuctionListingsController < ApplicationController
  before_action :require_character!
  before_action :set_listing, only: [:destroy, :buy]

  def index
    @listings = AuctionListing.active.includes(inventory: :item, seller: []).order(created_at: :desc)
  end

  def new
    @inventory_items = current_character.inventories.includes(:item).where(equipped: false)
  end

  def create
    inventory = current_character.inventories.find(params[:inventory_id])

    if inventory.auction_listing&.active?
      redirect_to auction_listings_path, alert: "Cet objet est déjà en vente."
      return
    end

    listing = AuctionListing.create!(
      inventory: inventory,
      seller: current_character,
      price: params[:price].to_i
    )
    redirect_to auction_listings_path, notice: "#{listing.item.name} mis en vente pour #{listing.price} or."
  end

  def destroy
    if @listing.seller == current_character
      @listing.update!(status: "cancelled")
      redirect_to auction_listings_path, notice: "Annonce retirée."
    else
      redirect_to auction_listings_path, alert: "Tu ne peux pas retirer cette annonce."
    end
  end

  def buy
    if @listing.buy!(current_character)
      redirect_to auction_listings_path, notice: "#{@listing.item.name} acheté pour #{@listing.price} or !"
    else
      redirect_to auction_listings_path, alert: "Achat impossible (or insuffisant ou objet indisponible)."
    end
  end

  private

  def set_listing
    @listing = AuctionListing.find(params[:id])
  end
end
