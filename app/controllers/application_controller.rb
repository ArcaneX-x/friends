class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user_can_edit?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [:password, :password_confirmation, :current_password]
    )
  end

  def current_user_can_edit?(model)
    # Если у модели есть юзер и он залогиненный, пробуем у модели взять .event и
    # если он есть, проверяем его юзера на равенство current_user.
    user_signed_in? && (
      model.user == current_user ||
        (model.try(:event).present? && model.event.user == current_user)
    )
  end

  # private

  def default_url_options
    {locale: I18n.locale}
  end

  def set_locale
    # byebug
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    if current_user.present?
    current_user.preference.locale
    else
      I18n.default_locale
    end
    # current_user.preference.locale ? current_user.present? :
    # I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
end

