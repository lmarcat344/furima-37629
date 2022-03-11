class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    # deviseのUserモデルにパラメーターを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :last_name_zenkaku, :first_name_zenkaku, :last_name_kana, :first_name_kana, :birthday])
  end
end
