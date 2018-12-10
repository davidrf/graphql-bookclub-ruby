require "rails_helper"

RSpec.describe "exercise 05", type: :request do
  let!(:current_user) { create(:user) }
  let!(:collaborators) { create_list(:user, 5) }
  let(:collaborator_ids) { collaborators.map(&:id) }
  let!(:repository) do
    create(:repository_with_collaborators, with_collaborators: collaborators)
  end
  let(:headers) do
    { "Authorization" => "bearer #{current_user.id}" }
  end
  let(:query) { file_fixture("05_exercise.graphql").read }
  let(:order_by) do
    { direction: "ASC", field: "USERNAME"}
  end
  let(:variables) do
    { after: nil, first: 2, id: repository.id, orderBy: order_by }
  end
  let(:params) do
    { query: query, variables: variables }
  end

  it "should return the expected response" do
    # Get first 2
    post(graphql_url, headers: headers, params: params, as: :json)

    expect(response).to have_http_status :ok
    body = response.parsed_body
    expect(body["errors"]).not_to be, "errors: #{body["errors"]&.map { |error| error["message"] }&.join(", ")}"

    connection = body.dig("data", "repository", "collaboratorsConnection")
    after = connection.dig("pageInfo", "endCursor")
    hasNextPage = connection.dig("pageInfo", "hasNextPage")
    data_collaborators = connection.dig("collaborators")
    users = data_collaborators&.map { |collaborator| collaborator }

    expect(after).to be
    expect(hasNextPage).to eq(true)

    # Get next 2
    params[:variables].tap { |variables| variables.merge!(after: after) }
    post(graphql_url, headers: headers, params: params, as: :json)

    body = response.parsed_body
    connection = body.dig("data", "repository", "collaboratorsConnection")
    after = connection.dig("pageInfo", "endCursor")
    hasNextPage = connection.dig("pageInfo", "hasNextPage")
    data_collaborators = connection.dig("collaborators")
    users += data_collaborators&.map { |collaborator| collaborator }

    expect(after).to be
    expect(hasNextPage).to eq(true)

    # Get next 2
    params[:variables].tap { |variables| variables.merge!(after: after) }
    post(graphql_url, headers: headers, params: params, as: :json)

    body = response.parsed_body
    connection = body.dig("data", "repository", "collaboratorsConnection")
    hasNextPage = connection.dig("pageInfo", "hasNextPage")
    data_collaborators = connection.dig("collaborators")
    users += data_collaborators&.map { |collaborator| collaborator }

    expect(hasNextPage).to eq(false)
    expect(collaborators.count).to eq(users.count)
    users.each do |user|
      collaborator = collaborators.find { |collaborator| collaborator.id == user["id"] }
      expect(collaborator).to be
      expect(user["firstName"]).to eq(collaborator.first_name)
    end
  end
end