class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by name: params.dig(:session, :name)&.downcase

    if user&.authenticate(params.dig(:session, :password))
      log_in user
      params.dig(:session, :remember_me) == "1" ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = t(".failure_message")
    end
  end
end
