class Admin::StepsController < Admin::BaseController
  before_action :set_quest
  before_action :set_step, only: [:edit, :update, :destroy]

  def new
    @step = @quest.steps.new
    riddle = @step.build_riddle
    4.times { riddle.answers.build }
    @step.build_npc
  end

  def create
    @step = @quest.steps.new(step_params)
    if @step.save
      redirect_to admin_quest_path(@quest), notice: "Étape ajoutée."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # s'assure qu'il y a toujours au moins 4 champs réponse à afficher
    if @step.riddle
      missing = 4 - @step.riddle.answers.size
      missing.times { @step.riddle.answers.build } if missing > 0
    end
  end

  def update
    if @step.update(step_params)
      redirect_to admin_quest_path(@quest), notice: "Étape mise à jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @step.destroy
    redirect_to admin_quest_path(@quest), notice: "Étape supprimée."
  end

  private

  def set_quest
    @quest = Quest.find(params[:quest_id])
  end

  def set_step
    @step = @quest.steps.find(params[:id])
  end

  def step_params
    params.require(:step).permit(
      :position, :experience_reward,
      riddle_attributes: [:id, :question, :_destroy,
        answers_attributes: [:id, :text, :correct, :_destroy]],
      npc_attributes: [:id, :name, :hp, :strength, :avatar, :_destroy]
    )
  end
end
