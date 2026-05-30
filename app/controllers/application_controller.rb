class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  before_action :authenticate_user!
  before_action :load_current_character

  helper_method :current_character

  protected

  def load_current_character
    return unless user_signed_in?
    if session[:character_id]
      @current_character = current_user.characters.find_by(id: session[:character_id])
      session.delete(:character_id) if @current_character.nil?
    end
  end

  def current_character
    @current_character
  end

  def require_character!
    redirect_to root_path, alert: "Sélectionne un personnage d'abord." unless current_character
  end

  def require_game_master!
    redirect_to root_path, alert: "Accès refusé." unless current_user.game_master?
  end
end
