require "rails_helper"

RSpec.describe Country, type: :model do
  describe "Associations" do
    it{should have_many(:users).dependent(:nullify)}
  end
end
