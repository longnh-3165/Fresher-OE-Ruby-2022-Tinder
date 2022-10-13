require "rails_helper"
RSpec.describe MatchPagesController, type: :controller do
  let!(:user1){create(:user, name: "hoang long")}
  let!(:user2){create(:user, type_of: "gold")}
  before do
    sign_in user1
  end

  describe "GET #index" do
    subject { user2 }
    context "when params is nil" do
      it do
        is_expected.to eq user2
      end
    end
  end

  describe "GET #next" do
    context "when click button next" do
      before do
        get :index, params: {page: 1}
      end
      it do
        redirect_to match_path(page: 2)
      end
    end
  end
end
