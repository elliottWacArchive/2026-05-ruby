class Admin::CharactersController < Admin::BaseController
  def index
    @characters = Character.includes(:user, :quest_progresses).order(:name)
  end

  def show
    @character = Character.includes(:user, quest_progresses: :quest).find(params[:id])
    @active_progress = @character.quest_progresses.find_by(status: "in_progress")
    @messages = if @active_progress
      step = @active_progress.current_step
      step&.npc ? Message.where(npc: step.npc, character: @character).order(:created_at) : []
    else
      []
    end
  end
end
