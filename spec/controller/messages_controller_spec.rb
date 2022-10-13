require "rails_helper"
RSpec.describe MessagesController, type: :controller do
  let!(:user1){create(:user, name: "hoang long")}
  let!(:user2){create(:user, type_of: "gold")}

  before {sign_in user1}

  describe "POST #create" do
    before do
      user2.like user1
      user1.like user2
    end
    context "when create message success" do
      let(:params) do
        {message:
        {content: "abcv",
        user_receive_id: user2.id
        }}
      end
      it do
        expect{
          post :create, params: params
        }.to change(Message,:count).by(1)
      end
    end
  end
end
