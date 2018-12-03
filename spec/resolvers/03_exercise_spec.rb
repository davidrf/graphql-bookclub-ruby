require 'rails_helper'

# empty class has been defined in
# app/graphql/resolvers/query_type/repository.rb
RSpec.describe Resolvers::QueryType::Repository do
  xdescribe ".perform" do
    let!(:current_user) { create(:user) }
    let!(:repository_not_owned) { create(:repository) }
    let(:context) do
      { current_user: current_user }
    end
    let(:id) { repository.id }

    context "public repository" do
      let!(:repository) { create(:repository) }

      it "should return the repository" do
        result = described_class.perform(context: context, id: id, object: nil)

        expect(result).to eq(repository)
      end
    end

    context "id does not correspond to any existing repository" do
      let(:id) { "does-not-exist" }

      it "should raise an error" do
        expect do
          described_class.perform(context: context, id: id, object: nil)
        end.to raise_error do |error|
          expect(error).to be_a(GraphQL::ExecutionError)
          expect(error.message).to eq("repository not found")
          expect(error.to_h).to match({
            "message"=>"repository not found",
            "extensions"=>{"code"=>"NOT_FOUND"}
          })
        end
      end
    end

    context "private repository owned by user" do
      let!(:repository) { create(:private_repository, user: current_user) }

      it "should return the repository" do
        result = described_class.perform(context: context, id: id, object: nil)

        expect(result).to eq(repository)
      end
    end

    context "private repository not owned by user" do
      let!(:repository) { create(:private_repository) }

      it "should raise an error" do
        expect do
          described_class.perform(context: context, id: id, object: nil)
        end.to raise_error do |error|
          expect(error).to be_a(GraphQL::ExecutionError)
          expect(error.message).to eq("repository not found")
          expect(error.to_h).to match({
            "message"=>"repository not found",
            "extensions"=>{"code"=>"NOT_FOUND"}
          })
        end
      end
    end
  end
end
