class ApplicationController < ActionController::Base
  include Pagy::Backend
  add_flash_types :success, :danger, :warning
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def after_sign_in_path_for resource
    stored_location_for(resource) || resource
  end

  def after_sign_out_path_for resource
    stored_location_for(resource) || new_user_session_path
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def authorize_admin
    return if current_user.admin?

    redirect_to root_path, status: :unauthorized
  end

  def get_users
    @pagy, @users = pagy(User.all, items: Settings.digits.size_of_admin_page)
  end
end
