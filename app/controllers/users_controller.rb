class UsersController < ApplicationController
  before_action :find_user_by_id, :authenticate_user!, except: %i(new create)

  def show; end

  private

  def find_user_by_id
    @user = User.find_by id: params[:id]

    return if @user

    flash[:danger] = t ".not_found"
    render "shared/_not_found"
  end
end
