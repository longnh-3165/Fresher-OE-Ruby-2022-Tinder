class UsersController < ApplicationController
  before_action :find_user_by_id, :logged_in_user, except: %i(new create)
  before_action :correct_user, only: %i(edit update)

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash[:danger] = t ".danger"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash[:danger] = t ".danger"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(User::ALLOWED_USER_PARAMS)
  end

  def find_user_by_id
    @user = User.find_by id: params[:id]

    return if @user

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end
end
