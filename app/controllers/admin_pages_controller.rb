class AdminPagesController < ApplicationController
  before_action :authorize_admin, :get_users

  def index; end
end
