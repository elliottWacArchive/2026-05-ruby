class QuestProgressesController < ApplicationController
  before_action :require_character!
  before_action :set_quest
  before_action :set_progress, only: [:answer_riddle, :skip_to_reward]

  def create
    existing = current_character.quest_progresses.find_by(quest_id: @quest.id)
    if existing
      redirect_to quest_path(@quest), notice: "Quête déjà en cours."
      return
    end

    progress = current_character.quest_progresses.create!(quest: @quest, current_step_index: 0, status: "in_progress")
    redirect_to quest_path(@quest)
  end

  def answer_riddle
    step = @progress.current_step
    riddle = step.riddle

    if riddle.correct_answer?(params[:answer_id])
      xp = current_character.add_experience(step.experience_reward)
      @progress.advance!

      if @progress.completed?
        handle_quest_completion
      else
        redirect_to quest_path(@quest), notice: "Bonne réponse ! +#{xp} XP"
      end
    else
      redirect_to quest_path(@quest), alert: "Mauvaise réponse, essaie encore."
    end
  end

  def skip_to_reward
    # permet de passer directement à la récompense après victoire au combat
    step = @progress.current_step
    xp = current_character.add_experience(step.experience_reward)
    @progress.advance!

    if @progress.completed?
      handle_quest_completion
    else
      redirect_to quest_path(@quest), notice: "+#{xp} XP. Étape suivante !"
    end
  end

  private

  def set_quest
    @quest = Quest.includes(steps: [:riddle, :npc]).find(params[:quest_id])
  end

  def set_progress
    @progress = current_character.quest_progresses.find(params[:id])
  end

  def handle_quest_completion
    xp = current_character.add_experience(@quest.completion_xp)
    # propose 3 objets aléatoires
    reward_items = Item.order("RANDOM()").limit(3)
    session[:reward_items] = reward_items.map(&:id)
    redirect_to quest_path(@quest), notice: "Quête terminée ! +#{xp} XP bonus ! Choisis ta récompense."
  end
end
