class QuestsController < ApplicationController
  before_action :require_character!

  def index
    @quests = Quest.includes(:steps).all
    @progresses = current_character.quest_progresses.index_by(&:quest_id)
  end

  def show
    @quest = Quest.includes(steps: [:riddle, :npc]).find(params[:id])
    @progress = current_character.quest_progresses.find_by(quest_id: @quest.id)

    if @progress&.completed? && session[:reward_items].blank?
      redirect_to quests_path, notice: "Tu as déjà terminé cette quête."
    end
  end

  def claim_reward
    @quest = Quest.find(params[:id])
    item = Item.find(params[:item_id])
    reward_ids = session[:reward_items]

    unless reward_ids&.include?(item.id)
      redirect_to quest_path(@quest), alert: "Récompense invalide."
      return
    end

    current_character.inventories.create!(item: item, equipped: false)
    session.delete(:reward_items)

    redirect_to character_path(current_character), notice: "Tu as obtenu : #{item.name} !"
  end
end
