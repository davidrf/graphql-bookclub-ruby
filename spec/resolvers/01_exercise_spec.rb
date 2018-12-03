require 'rails_helper'

# empty class has been defined in
# app/graphql/resolvers/query_type/current_user.rb
# also handy Resolver module has been defined in
# app/graphql/resolvers/concerns/resolver.rb
RSpec.describe Resolvers::QueryType::CurrentUser do
  describe ".perform" do
    let!(:user) { create(:user) }
    let(:context) do
      { current_user: user }
    end

    xit "should resolve the current user" do
      result = described_class.perform(object: nil, context: context)
      expect(result).to eq(user)
    end
  end
end
