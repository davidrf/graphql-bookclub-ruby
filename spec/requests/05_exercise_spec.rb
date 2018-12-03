require "rails_helper"

RSpec.describe "exercise 5", type: :request do
  let!(:repository_1) { create(:repository) }
  let!(:repository_2) { create(:repository) }
  let!(:current_user) { create(:user) }
  let(:query) { file_fixture("05_exercise.graphql").read }
  let(:headers) do
    { "Authorization" => "bearer #{current_user.id}" }
  end
  let(:variables) do
    { id1: repository_1.id, id2: repository_2.id }
  end
  let(:params) do
    { query: query, variables: variables }
  end
  let(:resolver_class) { Resolvers::RepositoryType::User }

  xit "should return the expected response" do
    expect(resolver_class).to receive(:perform).and_call_original.twice
    # called twice and not once because an additional query is made during authentication
    expect(User).to receive(:find_by_sql).and_call_original.twice

    post(graphql_url, headers: headers, params: params)

    expect(response).to have_http_status :ok
    body = response.parsed_body

    expect(body["errors"]).not_to be, "errors: #{body["errors"]&.map { |error| error["message"] }&.join(', ')}"
    data_repository_1_user_first_name = body.dig("data", "repository1", "user", "firstName")
    expect(data_repository_1_user_first_name).to eq repository_1.user.first_name

    data_repository_2_user_first_name = body.dig("data", "repository2", "user", "firstName")
    expect(data_repository_2_user_first_name).to eq repository_2.user.first_name
  end
end