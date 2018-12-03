require 'rails_helper'

# empty class has been defined in
# app/graphql/resolvers/repository_type/user.rb
RSpec.describe Resolvers::RepositoryType::User do
  describe ".perform" do
    let!(:current_user) { create(:user) }
    let!(:object) { create(:repository) }
    let(:context) do
      { current_user: current_user }
    end

    it "should return a GraphQL wrapper for a lazily loaded user" do
      result = described_class.perform(context: context, object: object)

      expect(result).to be_a(BatchLoader::GraphQL::Wrapper)
      user = result.sync
      expect(user).to eq(object.user)
    end
  end
end
