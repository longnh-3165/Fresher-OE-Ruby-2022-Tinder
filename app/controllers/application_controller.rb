class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend

  before_action :set_locale

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t ".not_logged"
    redirect_to root_path
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    user_not_found
  end

  def user_not_found
    flash[:danger] = t ".not_found"
    redirect_to root_url
  end
end
