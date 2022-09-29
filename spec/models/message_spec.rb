require "rails_helper"

RSpec.describe Message, type: :model do
  describe "Associations" do
    it{should belong_to(:user).with_foreign_key(:user_send_id)}
  end

  describe "Scopes" do
    let(:users){FactoryBot.create_list(:user, 3)}

    let!(:msg1) do
      FactoryBot.create :message, user_send_id: users[0].id,
                                  user_receive_id: users[1].id
    end

    let!(:msg2) do
      FactoryBot.create :message, user_send_id: users[1].id,
                                  user_receive_id: users[0].id
    end

    let!(:msg3){FactoryBot.create :message, user_send_id: users[0].id}

    it "sort desc" do
      expect(Message.newest.pluck(:id)).to eq [msg3.id, msg2.id, msg1.id]
    end

    context "when search for messages with inputs" do
      it "by user_send_id" do
        expect(msg_by(users[1].id)).to eq [msg2.id]
      end

      it "by user_send_id" do
        expect(msg_by(users[2].id)).to be_empty
      end

      it "by user_receiver_id" do
        expect(msg_for(users[1].id)).to eq [msg1.id]
      end

      it "by user_receiver_id" do
        expect(msg_for(users[2].id)).to be_empty
      end
    end

    context "when search for messages without inputs" do
      it "by user_send_id" do
        expect(msg_by(nil)).to be_empty
      end

      it "by user_receiver_id" do
        expect(msg_for(nil)).to eq [msg3.id]
      end
    end
  end

  describe "Delegations" do
    it{should delegate_method(:name).to(:user).with_prefix(true).allow_nil}
  end
end
