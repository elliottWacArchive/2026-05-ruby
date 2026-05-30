class Admin::DashboardController < Admin::BaseController
  def index
    @active_progresses = QuestProgress.includes(:character, :quest)
                                       .where(status: "in_progress")
                                       .order(updated_at: :desc)
    @characters_count = Character.count
    @quests_count = Quest.count
    @items_count = Item.count
  end
end
