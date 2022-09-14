class MatchPagesController < ApplicationController
  include MatchPagesHelper

  before_action :get_users, :logged_in_user
  before_action :find_user, only: %i(create)
  after_action :check_relationship, only: %i(create)

  def create
    current_user.like @user

    respond_to do |format|
      format.js{flash.now[:success] = t ".success_message"}
    end
  end

  def check_relationship
    return unless current_user.like_each_other? @user

    respond_to do |format|
      format.js{flash.now[:info] = "matched"}
    end
  end

  private

  def get_users
    @pagy, @users = pagy(User.all, items: Settings.digits.size_of_page)
  end
end
