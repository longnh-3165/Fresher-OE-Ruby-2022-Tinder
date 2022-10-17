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

  private

  def update_user_params
    return unless params[:user][:password].blank? &&
                  params[:user][:password_confirmation].blank?

    params[:user].delete(:password)
    params[:user].delete(:password_confirmation)
  end
end
