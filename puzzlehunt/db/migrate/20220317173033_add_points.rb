class AddPoints < ActiveRecord::Migration[7.0]
  def change
    add_column :puzzles, :points_to_unlock, :integer, default: 0, null: false
    add_column :puzzles, :points_for_solve, :integer, default: 1, null: false
    add_column :puzzle_hunts, :points_to_win, :integer, default: 0, null: false
  end
end
