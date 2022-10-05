require "rails_helper"

RSpec.describe AdminPagesController, type: :controller do
  let!(:admin) { create(:user, admin: true) }
  let(:user) { create(:user, type_of: 0) }
  describe "GET #index" do
    before do
      sign_in admin
    end

    context "ransack search by name" do
      let(:params){{name_cont: "long"}}
      before { get :index, params: params }
      it "should return user" do
        expect(assigns(:users).first).to eq admin
      end
    end

    context "ransack search by type of"
      let(:params){{type_of: "gold"}}
      before { get :index, params: params }
      it "should return gold user" do
        expect(assigns(:users).first).to eq admin
      end
  end

  describe "PATCH #upgrade" do
    before do
      sign_in admin
    end

    context "switch role user success" do
      before {patch :upgrade, params: { id: admin.id}}
      it "should update role user" do
        expect(response).to redirect_to admin_path
      end
    end

    context "switch role user failure" do
      before {patch :upgrade, params: { id: -1}}
      it do
        expect(response).to redirect_to admin_path
      end
    end
  end
end
