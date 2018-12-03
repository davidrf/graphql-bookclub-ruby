require "rails_helper"

RSpec.describe "exercise 3", type: :request do
  let!(:repository) { create(:repository) }
  let!(:current_user) { create(:user) }
  let(:query) { file_fixture("03_exercise.graphql").read }
  let(:headers) do
    { "Authorization" => "bearer #{current_user.id}" }
  end
  let(:variables) do
    { id: repository.id }
  end
  let(:params) do
    { query: query, variables: variables }
  end
  let(:resolver_class) { Resolvers::QueryType::Repository }

  xit "should return the expected response" do
    expect(resolver_class).to receive(:perform).and_call_original
    post(graphql_url, headers: headers, params: params)

    expect(response).to have_http_status :ok
    body = response.parsed_body

    expect(body["errors"]).not_to be, "errors: #{body["errors"]&.map { |error| error["message"] }&.join(', ')}"
    data_repository = body.dig("data", "repository")
    expect(data_repository["id"]).to eq repository.id
    expect(data_repository["name"]).to eq repository.name
  end
end