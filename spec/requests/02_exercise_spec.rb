require "rails_helper"

RSpec.describe "exercise 02", type: :request do
  let!(:current_user) { create(:user) }
  let!(:repository) { create(:repository_with_collaborators) }
  let(:collaborators_count) { repository.collaborators.count }
  let(:headers) do
    { "Authorization" => "bearer #{current_user.id}" }
  end
  let(:query) { file_fixture("02_exercise.graphql").read }
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

    expect(body["errors"]).not_to be, "errors: #{body["errors"]&.map { |error| error["message"] }&.join(", ")}"
    total_count = body.dig("data", "repository", "collaboratorsConnection", "totalCount")
    expect(total_count).to eq(collaborators_count)
  end
end