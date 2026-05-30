class QuestProgress < ApplicationRecord
  belongs_to :character
  belongs_to :quest

  validates :status, inclusion: { in: %w[in_progress completed] }

  def current_step
    quest.steps.order(:position)[current_step_index]
  end

  def advance!
    next_index = current_step_index + 1
    if next_index >= quest.steps.count
      update!(status: "completed")
    else
      update!(current_step_index: next_index)
    end
  end

  def completed?
    status == "completed"
  end
end
