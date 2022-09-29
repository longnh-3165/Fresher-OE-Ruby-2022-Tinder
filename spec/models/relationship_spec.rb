require "rails_helper"

RSpec.describe Relationship, type: :model do
  describe "Associations" do
    it{should belong_to(:follower).class_name(User.name)}
    it{should belong_to(:followed).class_name(User.name)}
  end

  describe "Scopes" do
    let(:users){FactoryBot.create_list(:user, 3)}

    let!(:r1) do
      FactoryBot.create :relationship, follower_id: users[0].id,
                                       followed_id: users[1].id,
                                       status: true
    end
    let!(:r2) do
      FactoryBot.create :relationship, follower_id: users[1].id,
                                       followed_id: users[0].id,
                                       status: false
    end

    context "when search for relationships with inputs" do
      it "by follower_id" do
        expect(liked_by(users[0].id)).to eq [r1.id]
      end

      it "by follower_id" do
        expect(liked_by(users[2].id)).to be_empty
      end

      it "by followed_id" do
        expect(is_liked?(users[0].id)).to eq [r2.id]
      end

      it "by followed_id" do
        expect(is_liked?(users[2].id)).to be_empty
      end
    end

    context "when search for relationships without inputs" do
      it "by follower_id" do
        expect(liked_by(nil)).to be_empty
      end

      it "by followed_id" do
        expect(is_liked?(nil)).to be_empty
      end
    end

    it "search by status" do
      expect(Relationship.relationship_users.pluck(:id)).to eq [r1.id]
    end
  end
end
