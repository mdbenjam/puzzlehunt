class AnswersController < ApplicationController
  def create
    @puzzle = Puzzle.find(params[:puzzle_id])
    @answer = @puzzle.answers.create(text: params[:answer], user: current_user)

    redirect_to(@puzzle)
  end
end
