class PuzzlesController < ApplicationController
  def index
    @puzzles = Puzzle.all
  end

  def show
    @puzzle = Puzzle.find(params[:id])
    @answers = @puzzle.answers.where(user: current_user)
  end

  def show_content
    @puzzle = Puzzle.find(params[:id])

    requested_file = params['file']
    if requested_file
      file_to_return =
        @puzzle.content_files.find do |file|
          file.filename.to_s.starts_with?(requested_file)
        end

      send_data file_to_return.download,
                filename: requested_file,
                type: file_to_return.content_type
    else
      if @puzzle.default_attachment.content_type == 'application/pdf'
        redirect_to url_for(@puzzle.default_attachment)
      elsif @puzzle.default_attachment.content_type == 'text/html'
        render html: @puzzle.default_attachment.download.html_safe
      end
    end
  end
end
