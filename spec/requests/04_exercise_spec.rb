require "rails_helper"

RSpec.describe "exercise 4", type: :request do
  let!(:user) { create(:user) }
  let(:query) { file_fixture("04_exercise.graphql").read }
  let(:variables) do
    { id: user.id }
  end
  let(:params) do
    { query: query, variables: variables }
  end

  it "should return the expected response" do
    post(graphql_url, params: params)

    expect(response).to have_http_status :ok
    body = response.parsed_body

    expect(body["errors"]).not_to be, "errors: #{body["errors"]&.map { |error| error["message"] }&.join(', ')}"

    expect(body.dig("data", "user", "id")).to eq user.id
    expect(body.dig("data", "user", "firstName")).to eq user.first_name
  end
end