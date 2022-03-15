class PuzzlesController < ApplicationController
  before_action :authenticate_user!
  def index
    @puzzles = Puzzle.all
  end

  def show
    @puzzle = Puzzle.find(params[:id])
    @answers = @puzzle.answers.where(user: current_user)
    for answer in @answers
      print("answer: " + answer.text)
    end
  end
end
