class PuzzleHuntsController < ApplicationController
  def index
    @active_hunts = PuzzleHunt.where(active: true)

    return redirect_to(@active_hunts[0]) if @active_hunts.length == 1
  end

  def show
    @puzzle_hunt = PuzzleHunt.find(params[:id])
    @unlocked_puzzles = @puzzle_hunt.unlocked_puzzles(current_user)
  end
end
