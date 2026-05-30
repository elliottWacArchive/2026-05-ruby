class MessagesController < ApplicationController
  # le mj n'a pas forcément de personnage actif, on ne force pas require_character!
  before_action :authenticate_user!

  def create
    npc = Npc.find(params[:npc_id])
    # le character visé est passé dans le form (celui du joueur côté admin, ou current_character côté joueur)
    character = if params[:character_id].present?
      Character.find(params[:character_id])
    else
      current_character
    end

    unless character
      redirect_back fallback_location: root_path, alert: "Personnage introuvable."
      return
    end

    message = Message.new(npc: npc, user: current_user, character: character, content: params[:content])

    if message.save
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path, alert: message.errors.full_messages.join(", ")
    end
  end
end
