class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:health]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def health
    head :ok
  end
end
