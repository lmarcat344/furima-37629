class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth, except: [:index, :show]

  private

  def configure_permitted_parameters
    # deviseのUserモデルにパラメーターを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :last_name_zenkaku, :first_name_zenkaku, :last_name_kana, :first_name_kana, :birthday])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
