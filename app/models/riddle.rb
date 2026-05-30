class Riddle < ApplicationRecord
  belongs_to :step
  has_many :answers, dependent: :destroy

  validates :question, presence: true

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :all_blank

  def correct_answer?(answer_id)
    answers.find_by(id: answer_id)&.correct?
  end
end
