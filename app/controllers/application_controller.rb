class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :require_login
end
