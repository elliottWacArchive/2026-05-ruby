class Admin::BaseController < ApplicationController
  before_action :require_game_master!

  layout "admin"
end
