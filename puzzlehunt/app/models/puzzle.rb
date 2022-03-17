class Puzzle < ApplicationRecord
  has_many_attached :content_files
  has_many :answers
  belongs_to :puzzle_hunt

  def solved?(user)
    !!self.correct_answer(user)
  end

  def correct_answer(user)
    self.answers.where(user: user, correct: true).first&.text&.upcase
  end

  def default_attachment
    content_files.find do |file|
      file.content_type == 'application/pdf' ||
        (file.content_type == 'text/html' && file.filename == 'index.html')
    end
  end
end
