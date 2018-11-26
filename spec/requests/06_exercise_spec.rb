require "rails_helper"

RSpec.describe "exercise 6", type: :request do
  let!(:repository) { create(:repository) }
  let(:query) { file_fixture("06_exercise.graphql").read }
  let(:variables) do
    { id: repository.id }
  end
  let(:params) do
    { query: query, variables: variables }
  end

  xit "should return the expected response" do
    post(graphql_url, params: params)

    expect(response).to have_http_status :ok
    body = response.parsed_body

    expect(body["errors"]).not_to be, "errors: #{body["errors"]&.map { |error| error["message"] }&.join(', ')}"

    expect(body.dig("data", "repository", "id")).to eq repository.id
    expect(body.dig("data", "repository", "name")).to eq repository.name
  end
end