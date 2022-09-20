class AdminPagesController < ApplicationController
  before_action :authorize_admin, :get_users

  def index; end

  def upgrade
    user = User.find_by id: params[:id]
    if switch_role user
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
