require "rails_helper"

RSpec.describe "exercise 03", type: :request do
  let!(:current_user) { create(:user) }
  let!(:repository) { create(:repository_with_collaborators) }
  let(:collaborations) { repository.collaborations }
  let(:collaborations_count) { collaborations.count }
  let(:headers) do
    { "Authorization" => "bearer #{current_user.id}" }
  end
  let(:query) { file_fixture("03_exercise.graphql").read }
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
    edges = body.dig("data", "repository", "collaboratorsConnection", "edges")
    expect(edges.count).to eq(collaborations_count)
    edges.each do |edge|
      collaboration = collaborations.find { |collaborator| collaborator.id == edge["id"] }
      expect(collaboration).to be
      edge_created_at = Time.zone.parse(edge["createdAt"])
      expect(edge_created_at.to_s).to eq(collaboration.created_at.to_s)
    end
  end
end