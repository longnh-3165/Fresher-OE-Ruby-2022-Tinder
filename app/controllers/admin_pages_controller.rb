class AdminPagesController < ApplicationController
  before_action :authorize_admin, :get_users

  def index
    check_no_params = User::CREATE_ATTRS.all? do |key|
      params[key].nil?
    end
    check_no_params ? get_users : search
  end

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

  def search_params
    params.require(:search).permit(User::CREATE_ATTRS)
  end

  private

  def search
    @pagy,
    @users = pagy(User.by_name_like(params[:name])
                      .by_actived(params[:actived])
                      .by_admin(params[:admin])
                      .by_type_of(params[:type_of]),
                  items: Settings.digits.size_of_admin_page)
  end
end
