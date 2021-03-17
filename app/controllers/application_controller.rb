class ApplicationController < ActionController::Base

  
  before_action :set_locale
  #before_action :switch_locale
  around_action :switch_locale
  #after_action :switch_locale
  before_action :configure_permitted_parameters, if: :devise_controller?


  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end


  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  # def set_locale
  #   if params[:locale].present?
  #     cookies.permanent[:locale] = params[:locale] # save cookies
  #   end
  #
  #   locale = cookies[:locale]&.to_sym # read cookies
  #
  #   if I18n.available_locales.include?(locale)
  #     I18n.locale = locale # use cookies locale
  #   end
  # end



  def default_url_options(options={})
    { locale: I18n.locale }
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
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :website, :bio, :avatar])
  end




end
