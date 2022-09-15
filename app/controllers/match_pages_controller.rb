class MatchPagesController < ApplicationController
  include MatchPagesHelper

  before_action :get_users, :logged_in_user
  before_action :find_user, only: %i(create)

  def match
    check_no_params = %i(gender_choice age_choice place_choice).all? do |key|
      params[key].nil?
    end
    if check_no_params
      get_users
    else
      filter params[:gender_choice], params[:age_choice], params[:place_choice]
    end
  end

  def create
    current_user.like @user

    respond_to do |format|
      format.js{flash.now[:success] = t ".success_message"}
    end
  end

  def filter gender, age, place
    age_range = age.nil? ? Settings.age.range : age.split("-", 2)
    @pagy,
    @users = pagy(User.by_gender(gender)
                      .by_age(age_range[1].to_i, age_range[0].to_i)
                      .by_place(place),
                  items: Settings.digits.size_of_page)
    return if @users.present?

    flash[:danger] = t ".errors.no_user"
    get_users
  end

  private

  def get_users
    @pagy, @users = pagy(User.all, items: Settings.digits.size_of_page)
  end
end
