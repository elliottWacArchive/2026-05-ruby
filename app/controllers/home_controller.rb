class HomeController < ApplicationController
  def index
    @characters = current_user.characters.order(:name)
  end
end
