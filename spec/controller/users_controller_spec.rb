require "rails_helper"
include SessionsHelper
RSpec.describe UsersController, type: :controller do
  let(:user_1) {FactoryBot.create :user}
  describe "GET #show" do
    context "when user logged" do
      before do
        log_in user_1
        get :show, params: params
      end

      context "when found" do
        let(:params){{id: user_1.id}}
        it do
          expect(response).to render_template :show
        end
      end

      context "when not found" do
        let(:params){{id: -1}}
        it do
          expect(response).to render_template("shared/_not_found")
        end
      end
    end
  end
  describe "GET #new" do
    before do
      get :new
    end

    it "should create a new user" do
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe "POST #create" do
    before do
      post :create, params:{user:
        {name: "user_test", date_of_birth: "1998-01-20", gender: "male", email: "test@gmail.com", facebook: "facebook.com", phone: "0932123123", description: "zxczxc", password: "123456"}}
    end

    context "user save success" do
      it "save success" do
        expect(assigns(:user)).to eq(User.last)
      end
    end

    context "user save failed" do
      before do
        post :create, params:{user:
          {name: "user_test", date_of_birth: "1998-01-20", gender: "male", email: "test@gmail.com", facebook: "facebook.com", phone: "0932123123", description: "zxczxc", password: "123456"}}
      end

      it "redirect to page create" do
        expect(assigns(:user)).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    before do
      log_in user_1
    end

    context "user save success" do
      it "save success" do
        patch :update, params:{id: user_1.id, user: {name: "user_test", password: "123456"}}

        is_expected.to redirect_to user_path(user_1)
      end
    end

    context "user save failed" do
      it "save failed" do
        patch :update, params:{id: user_1.id, user: {name: nil}}
        expect(response).to render_template :edit
      end
    end
  end
end
