class UsersController < ApplicationController
  before_action :find_user_by_id, :authenticate_user!, except: %i(new create)

  def show; end

  def destroy
    if @user.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end
    redirect_to admin_root_path
  end
end
