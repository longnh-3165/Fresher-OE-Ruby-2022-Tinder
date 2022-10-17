module Api::V1
  class AdminPagesController < ApiController
    skip_before_action :verify_authenticity_token

    def index
      @search = User.ransack(params[:q])
      @pagy, @users = pagy @search.result
      render json: {users: @users, pagy: @pagy, status: :ok}
    end

    def upgrade
      user = User.find_by id: params[:id]
      if user
        user.switch_role
        render json: {user: user, status: :ok}
      else
        render json: {users: @users, pagy: @pagy, status: :bad_request}
      end
    end
  end
end
