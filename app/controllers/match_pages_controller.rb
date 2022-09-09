class MatchPagesController < ApplicationController
  include MatchPagesHelper

  after_action :random_user, only: %i(create)
  before_action :get_users
  before_action :random_user
  before_action :logged_in_user
  before_action :find_user, only: %i(create)
  def create
    current_user.like @user
  end

  def get_users
    @users = User.all
  end

  def random_user
    @pagy_user = @users.sample(10)
  end
end
