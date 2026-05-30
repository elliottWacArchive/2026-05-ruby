class Admin::QuestsController < Admin::BaseController
  before_action :set_quest, only: [:show, :edit, :update, :destroy]

  def index
    @quests = Quest.includes(:steps).order(:name)
  end

  def show
    @steps = @quest.steps.includes(:riddle, :npc)
  end

  def new
    @quest = Quest.new
    @quest.steps.build.tap { |s| s.build_riddle.answers.build; s.build_npc }
  end

  def create
    @quest = Quest.new(quest_params)
    if @quest.save
      redirect_to admin_quest_path(@quest), notice: "Quête créée."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @quest.update(quest_params)
      redirect_to admin_quest_path(@quest), notice: "Quête mise à jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quest.destroy
    redirect_to admin_quests_path, notice: "Quête supprimée."
  end

  private

  def set_quest
    @quest = Quest.find(params[:id])
  end

  def quest_params
    params.require(:quest).permit(
      :name, :description, :completion_xp,
      steps_attributes: [
        :id, :position, :experience_reward, :_destroy,
        riddle_attributes: [:id, :question, :_destroy,
          answers_attributes: [:id, :text, :correct, :_destroy]],
        npc_attributes: [:id, :name, :hp, :strength, :avatar, :_destroy]
      ]
    )
  end
end
