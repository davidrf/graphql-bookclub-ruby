require "rails_helper"

RSpec.describe "exercise 01", type: :request do
  let!(:current_user) { create(:user) }
  let!(:collaborators) do
    user_c = create(:user, username: "c")
    user_a = create(:user, username: "a")
    user_b = create(:user, username: "b")

    [user_a, user_b, user_c]
  end
  let(:collaborator_ids) { collaborators.map(&:id) }
  let!(:repository) do
    create(:repository_with_collaborators, with_collaborators: collaborators)
  end
  let(:headers) do
    { "Authorization" => "bearer #{current_user.id}" }
  end
  let(:query) { file_fixture("01_exercise.graphql").read }
  let(:order_by) do
    { direction: direction, field: "USERNAME" }
  end
  let(:variables) do
    { id: repository.id, orderBy: order_by }
  end
  let(:params) do
    { query: query, variables: variables }
  end

  context "ascending direction" do
    let(:direction) { "ASC" }
    xit "should return the expected response" do
      post(graphql_url, headers: headers, params: params)

      expect(response).to have_http_status :ok
      body = response.parsed_body

      expect(body["errors"]).not_to be, "errors: #{body["errors"]&.map { |error| error["message"] }&.join(", ")}"
      edges = body.dig("data", "repository", "collaboratorsConnection", "edges")
      user_ids = edges&.map { |edge| edge.dig("node", "id") }
      expect(user_ids).to eq(collaborator_ids)
    end
  end

  context "descending direction" do
    let(:direction) { "DESC" }
    xit "should return the expected response" do
      post(graphql_url, headers: headers, params: params)

      expect(response).to have_http_status :ok
      body = response.parsed_body

      expect(body["errors"]).not_to be, "errors: #{body["errors"]&.map { |error| error["message"] }&.join(", ")}"
      edges = body.dig("data", "repository", "collaboratorsConnection", "edges")
      user_ids = edges&.map { |edge| edge.dig("node", "id") }
      expect(user_ids).to eq(collaborator_ids.reverse)
    end
  end

  context "orderBy not specified" do
    let(:order_by) { nil }
    xit "should return the expected response" do
      post(graphql_url, headers: headers, params: params)

      expect(response).to have_http_status :ok
      body = response.parsed_body

      expect(body["errors"]).not_to be, "errors: #{body["errors"]&.map { |error| error["message"] }&.join(", ")}"
      edges = body.dig("data", "repository", "collaboratorsConnection", "edges")
      user_ids = edges&.map { |edge| edge.dig("node", "id") }
      expect(user_ids).to eq(collaborator_ids)
    end
  end
end