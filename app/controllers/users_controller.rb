class UsersController < ApplicationController
  before_action :find_user_by_id, :authenticate_user!, except: %i(new create)
  before_action :update_user_params, only: :update

  def show; end

  def update
    if @user.update user_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash.now[:danger] = t ".danger"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end
    redirect_to admin_root_path
  end

  private

  def user_params
    params.require(:user).permit(User::ALLOWED_USER_PARAMS)
  end

  def update_user_params
    return unless params[:user][:password].blank? &&
                  params[:user][:password_confirmation].blank?

    params[:user].delete(:password)
    params[:user].delete(:password_confirmation)
  end
end
