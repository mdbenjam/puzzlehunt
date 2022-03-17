class Puzzle < ApplicationRecord
  has_one_attached :content
  has_many :answers
  belongs_to :puzzle_hunt

  def solved?(user)
    !!self.correct_answer(user)
  end

  def correct_answer(user)
    self.answers.where(user: user, correct: true).first&.text&.upcase
  end
end
