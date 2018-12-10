require "rails_helper"

RSpec.describe "exercise 0", type: :request do
  let!(:current_user) { create(:user) }
  let!(:repository) { create(:repository_with_collaborators) }
  let(:headers) do
    { "Authorization" => "bearer #{current_user.id}" }
  end
  let(:query) { file_fixture("00_exercise.graphql").read }
  let(:variables) do
    { id: repository.id }
  end
  let(:params) do
    { query: query, variables: variables }
  end

  it "should return the expected response" do
    post(graphql_url, headers: headers, params: params)

    expect(response).to have_http_status :ok
    body = response.parsed_body

    expect(body["errors"]).not_to be, "errors: #{body["errors"]&.map { |error| error["message"] }&.join(', ')}"
    edges = body.dig("data", "repository", "collaboratorsConnection", "edges")
    user_ids = edges&.map { |edge| edge.dig("node", "id") }
    expect(user_ids).to match_array(repository.collaborator_ids)
  end
end