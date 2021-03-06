class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def default_url_options(options={})
    { locale: I18n.locale }.merge options
  end

  # def extract_locale
  #   parsed_locale = request.host.split('.').last
  #   I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  # end

  def change_lang
    eng = :en
    jap = :ja
    if I18n.locale == eng
      params[:locale] = :ja
      I18n.locale = :ja
    elsif I18n.locale == jap
      params[:locale] = :en
      I18n.locale = :en
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :website, :bio])
  end




end
