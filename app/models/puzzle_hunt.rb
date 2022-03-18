class PuzzleHunt < ApplicationRecord
  has_many :puzzles

  def unlocked_puzzles(current_user)
    puzzles = self.puzzles
    current_score =
      puzzles.sum do |puzzle|
        puzzle.solved?(current_user) ? puzzle.points_for_solve : 0
      end
    puzzles.where('? >= points_to_unlock', current_score)
  end

  def completed_hunt(current_user)
    @completed_hunt ||=
      begin
        answers =
          Answer
            .where(correct: true, puzzle: { puzzle_hunt: self })
            .includes(:puzzle)
            .order(:created_at)

        answer_by_user = answers.group_by { |answer| answer.user_id }

        users_completed =
          answer_by_user.map do |user_id, answers|
            current_sum = 0
            for answer in answers
              current_sum += answer.puzzle.points_for_solve
              break if current_sum >= self.points_to_win
            end
            if current_sum >= self.points_to_win
              [user_id, answer.created_at]
            else
              [user_id, nil]
            end
          end.to_h

        sorted_users =
          users_completed.sort_by { |user_id, timestamp| timestamp || -1 }

        index = sorted_users.find_index { |arr| arr[0] == current_user.id }

        # If there's no completed time stamp then the user hasn't finished
        (index.nil? || sorted_users[index][1].nil?) ? nil : index + 1
      end
  end
end
