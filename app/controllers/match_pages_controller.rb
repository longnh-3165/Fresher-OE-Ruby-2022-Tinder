class MatchPagesController < ApplicationController
  include MatchPagesHelper

  before_action :get_users, :logged_in_user
  before_action :find_user, only: %i(create)

  def create
    current_user.like @user
    check_relationship
    @like = t ".success_message"
    respond_to do |format|
      format.js
    end
  end

  private

  def check_relationship
    @connected = current_user.like_each_other? @user
    @matched = t ".matched"
  end

  def get_users
    @pagy, @users = pagy(User.all, items: Settings.digits.size_of_page)
  end
end
