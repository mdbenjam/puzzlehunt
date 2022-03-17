class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:health]

  def health
    head :ok
  end
end
