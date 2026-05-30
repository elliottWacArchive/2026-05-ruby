class Answer < ApplicationRecord
  belongs_to :riddle

  validates :text, presence: true
end
