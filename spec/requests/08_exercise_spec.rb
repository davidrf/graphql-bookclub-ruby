require "rails_helper"

RSpec.describe "exercise 8", type: :request do
  let(:user_params) do
    attributes_for(:user).transform_keys { |key| key.to_s.camelize(:lower) }
  end
  let(:query) { file_fixture("08_exercise.graphql").read }
  let(:variables) do
    { input: user_params }
  end
  let(:params) do
    { query: query, variables: variables }
  end

  it "should return the expected response" do
    post(graphql_url, params: params)

    expect(response).to have_http_status :ok
    body = response.parsed_body

    expect(body["errors"]).not_to be, "errors: #{body["errors"]&.map { |error| error["message"] }&.join(', ')}"

    user = body.dig("data", "createUser", "user")
    expect(user["bio"]).to eq user_params["bio"]
    expect(user["firstName"]).to eq user_params["firstName"]
    expect(user["lastName"]).to eq user_params["lastName"]
    expect(user["pictureUrl"]).to eq user_params["pictureUrl"]
    expect(user["username"]).to eq user_params["username"]
  end
end