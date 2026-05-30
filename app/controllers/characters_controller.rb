class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :select, :spend_points, :update_avatar]

  def new
    @character = current_user.characters.new
  end

  def create
    @character = current_user.characters.new(character_params)
    if @character.save
      session[:character_id] = @character.id
      redirect_to @character, notice: "Personnage créé ! Distribue tes points de départ."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def select
    session[:character_id] = @character.id
    redirect_to root_path, notice: "Personnage sélectionné : #{@character.name}"
  end

  def spend_points
    hp_add = params[:hp_points].to_i
    str_add = params[:strength_points].to_i
    total = hp_add + str_add

    if total > @character.unspent_points || total <= 0 || hp_add < 0 || str_add < 0
      redirect_to @character, alert: "Distribution invalide."
      return
    end

    @character.update!(
      base_hp: @character.base_hp + hp_add,
      base_strength: @character.base_strength + str_add,
      unspent_points: @character.unspent_points - total
    )
    redirect_to @character, notice: "Points distribués !"
  end

  def update_avatar
    if params[:avatar].present?
      @character.avatar.attach(params[:avatar])
      redirect_to @character, notice: "Avatar mis à jour."
    else
      redirect_to @character, alert: "Aucun fichier sélectionné."
    end
  end

  private

  def set_character
    @character = current_user.characters.find(params[:id])
  end

  def character_params
    params.require(:character).permit(:name)
  end
end
