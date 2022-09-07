class UsersController < ApplicationController
  before_action :logged_in_user

  def show
    @user = User.find_by id: params[:id]

    return if @user

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
