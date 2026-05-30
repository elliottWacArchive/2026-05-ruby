class CombatSessionsController < ApplicationController
  before_action :require_character!
  before_action :set_combat, only: [:show, :attack]

  def create
    npc = Npc.find(params[:npc_id])

    # si combat déjà en cours pour ce PNJ, on reprend
    existing = current_character.combat_sessions.find_by(npc: npc, status: "ongoing")
    if existing
      redirect_to combat_session_path(existing)
      return
    end

    combat = current_character.combat_sessions.create!(
      npc: npc,
      character_hp: current_character.effective_hp,
      npc_hp: npc.hp,
      status: "ongoing"
    )
    redirect_to combat_session_path(combat)
  end

  def show
    @npc = @combat.npc
    @quest = @npc.step.quest
    @progress = current_character.quest_progresses.find_by(quest: @quest)
  end

  def attack
    unless @combat.ongoing?
      redirect_to combat_session_path(@combat), alert: "Ce combat est terminé."
      return
    end

    @combat.player_attack!

    if @combat.won?
      handle_victory
    elsif @combat.lost?
      handle_defeat
    else
      redirect_to combat_session_path(@combat)
    end
  end

  private

  def set_combat
    @combat = current_character.combat_sessions.find(params[:id])
  end

  def handle_victory
    progress = current_character.quest_progresses.find_by(quest: @combat.npc.step.quest)
    redirect_to skip_to_reward_quest_quest_progress_path(
      @combat.npc.step.quest,
      progress
    ), notice: "Victoire ! Tu as vaincu #{@combat.npc.name}."
  end

  def handle_defeat
    # game over : on réinitialise les PV du personnage (il repart avec ses PV de base)
    current_character.update!(base_hp: current_character.base_hp)
    redirect_to quests_path, alert: "Game Over... #{@combat.npc.name} t'a vaincu. Tu repars de zéro sur cette quête."
  end
end
