require "rails_helper"

RSpec.describe "exercise 3", type: :request do
  let!(:users) do
    [
      create(:user),
      create(:user, bio: nil),
      create(:user, picture_url: nil),
    ]
  end
  let(:query) { file_fixture("03_exercise.graphql").read }
  let(:params) do
    { query: query }
  end

  it "should return the expected response" do
    post(graphql_url, params: params)

    expect(response).to have_http_status :ok
    body = response.parsed_body

    expect(body["errors"]).not_to be, "errors: #{body["errors"]&.map { |error| error["message"] }&.join(', ')}"

    data_users = body.dig("data", "users")
    expect(data_users).to be

    users.each do |user|
      matching_user = data_users.find do |data_user|
        data_user["id"] == user.id
      end

      expect(matching_user).to be
      expect(matching_user["bio"]).to eq user.bio
      expect(matching_user["firstName"]).to eq user.first_name
      expect(matching_user["lastName"]).to eq user.last_name
      expect(matching_user["pictureUrl"]).to eq user.picture_url
      expect(matching_user["username"]).to eq user.username
    end
  end
end