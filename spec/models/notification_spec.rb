require "rails_helper"

RSpec.describe Notification, type: :model do
  describe "Associations" do
    it{should belong_to(:user_send).class_name(User.name)}
    it{should belong_to(:user_receive).class_name(User.name)}
  end

  describe ".newest" do
    subject {Notification.newest}
    let!(:user_one) do
      FactoryBot.create :user, name: "user1", date_of_birth: "1998-01-20", gender: 0, type_of: 0, admin: true
    end
    let!(:user_two) do
      FactoryBot.create :user, name: "user2", date_of_birth: "1970-01-20", gender: 1, type_of: 1, admin: false
    end
    let!(:noti_1){FactoryBot.create :notification, id: 1, user_send: user_one, user_receive: user_two}
    let!(:noti_2){FactoryBot.create :notification, id: 2, user_send: user_one, user_receive: user_two}

    context "when get newest notification by created at" do
      it "newest" do
        expect(subject.ids).to eq ([noti_2.id, noti_1.id])
      end
    end
  end
end
