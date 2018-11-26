require "rails_helper"

RSpec.describe "exercise 2", type: :request do
  let!(:users) { create_list(:user, 3) }
  let(:query) { file_fixture("02_exercise.graphql").read }
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
    end
  end
end