class CreatePuzzleHunts < ActiveRecord::Migration[7.0]
  def change
    create_table :puzzle_hunts do |t|
      t.string :name
      t.datetime :start
      t.boolean :active
      t.timestamps
    end

    add_reference :puzzles, :puzzle_hunt, foreign_key: true
  end
end
