class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_current_user
  before_action :pages_protect

  # around_action :switch_locale

  # def switch_locale(&action)
  # I18n.with_locale(locale_from_header, &action)
  # end

  # private

  # def locale_from_header
  # request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  # end

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def pages_protect
    redirect_to new_session_path, alert: "You are not logged in" unless Current.user
  end
end
