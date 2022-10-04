class AdminPagesController < ApplicationController
  before_action :authorize_admin
  Pagy::DEFAULT[:items] = Settings.digits.size_of_admin_page

  def index
    @search = User.ransack(params[:q])
    @pagy, @users = pagy @search.result
  end

  def upgrade
    user = User.find_by id: params[:id]
    if user

      flash[:success] = t "sc_mes"
      redirect_back(fallback_location: admin_path)
    else
      flash[:danger] = t "f_mes"
      redirect_to admin_path
    end
  end

  def switch_role user
    user.basic? ? user.gold! : user.basic!
  end
end
