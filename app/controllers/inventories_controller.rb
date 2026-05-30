class InventoriesController < ApplicationController
  before_action :require_character!
  before_action :set_inventory, only: [:toggle_equip]

  def index
    @character = current_user.characters.find(params[:character_id])
    @inventories = @character.inventories.includes(:item)
    @equipped = { hat: nil, weapon: nil, shield: nil }
    @character.equipped_items.each { |i| @equipped[i.slot.to_sym] = i }
  end

  def toggle_equip
    if @inventory.equipped?
      @inventory.update!(equipped: false)
    else
      @inventory.update!(equipped: true)
    end
    redirect_to character_inventories_path(current_character), notice: "Inventaire mis à jour."
  end

  private

  def set_inventory
    @inventory = current_character.inventories.find(params[:id])
  end
end
