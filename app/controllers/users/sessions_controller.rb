class Users::SessionsController < Devise::SessionsController
  after_action :clear_character_session, only: [:destroy]

  private

  def clear_character_session
    session.delete(:character_id)
    session.delete(:reward_items)
  end
end
