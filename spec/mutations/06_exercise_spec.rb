require 'rails_helper'

# empty class has been defined in
# app/graphql/mutations/create_user.rb
# also handy Mutation module has been defined in
# app/graphql/resolvers/concerns/mutation.rb
RSpec.describe Mutations::CreateUser do
  describe ".perform" do
    let!(:current_user) { create(:user) }
    let(:input) { attributes_for(:user) }
    let(:context) do
      { current_user: current_user }
    end

    it "should return a payload with a user" do
      result = described_class.perform(context: context, input: input, object: nil)

      user = result[:user]
      expect(user.bio).to eq input[:bio]
      expect(user.first_name).to eq input[:first_name]
      expect(user.last_name).to eq input[:last_name]
      expect(user.picture_url).to eq input[:picture_url]
      expect(user.username).to eq input[:username]
    end
  end
end
