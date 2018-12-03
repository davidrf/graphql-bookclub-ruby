require 'rails_helper'

RSpec.describe Repository, type: :model do
  describe ".gen" do
    let!(:current_user) { create(:user) }
    let(:id) { repository.id }

    context "public repository" do
      let!(:repository) { create(:repository) }

      it "should return the repository" do
        result = described_class.gen(current_user: current_user, id: id)

        expect(result).to eq(repository)
      end
    end

    context "id does not correspond to any existing repository" do
      let(:id) { "does-not-exist" }

      it "should return nil" do
        result = described_class.gen(current_user: current_user, id: id)

        expect(result).to be_nil
      end
    end

    context "private repository owned by user" do
      let!(:repository) { create(:private_repository, user: current_user) }

      it "should return the repository" do
        result = described_class.gen(current_user: current_user, id: id)

        expect(result).to eq(repository)
      end
    end

    context "private repository not owned by user" do
      let!(:repository) { create(:private_repository) }

      it "should return nil" do
        result = described_class.gen(current_user: current_user, id: id)

        expect(result).to be_nil
      end
    end
  end
end
