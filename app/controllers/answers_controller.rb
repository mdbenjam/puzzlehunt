class AnswersController < ApplicationController
    def create
        @puzzle = Puzzle.find(params[:puzzle_id])
        @answer = @puzzle.answers.create(text: params[:answer], user: current_user)

        if @puzzle.correct_answer.downcase == @answer.text.downcase
            @answer.correct = true
            @answer.save
        end

        redirect_to(@puzzle)
    end

end
