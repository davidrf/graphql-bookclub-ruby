require "rails_helper"

RSpec.describe "exercise 7", type: :request do
  let(:repository) { create(:repository) }
  let(:user) { repository.user }
  let(:query) { file_fixture("07_exercise.graphql").read }
  let(:variables) do
    { repositoryId: repository.id, userId: user.id }
  end
  let(:params) do
    { query: query, variables: variables }
  end

  it "should return the expected response" do
    post(graphql_url, params: params)

    expect(response).to have_http_status :ok
    body = response.parsed_body

    expect(body["errors"]).not_to be, "errors: #{body["errors"]&.map { |error| error["message"] }&.join(', ')}"

    expect(body.dig("data", "repository", "user", "fullName")).to eq repository.user.full_name
    expect(body.dig("data", "user", "repositories", 0, "name")).to eq user.repositories.first.name
  end
end