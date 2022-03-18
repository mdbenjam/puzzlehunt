class Answer < ApplicationRecord
  belongs_to :puzzle
  belongs_to :user

  before_create :check_answer

  def self.check_stripped_answers(answer1, answer2)
    answer1.downcase.gsub(/[^a-z0-9]/i, '') ==
      answer2.downcase.gsub(/[^a-z0-9]/i, '')
  end

  def check_answer
    puzzle = self.puzzle

    puzzle_answer = puzzle.correct_answer.downcase.gsub(/[^a-z0-9]/i, '')
    given_answer = self.text.downcase.gsub(/[^a-z0-9]/i, '')

    self.correct = true if Answer.check_stripped_answers(
      puzzle_answer,
      given_answer,
    )
  end
end
