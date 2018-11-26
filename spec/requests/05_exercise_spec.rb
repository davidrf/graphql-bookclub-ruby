require "rails_helper"

RSpec.describe "exercise 5", type: :request do
  let!(:user) { create(:user) }
  let(:query) { file_fixture("05_exercise.graphql").read }
  let(:variables) do
    { id: user.id }
  end
  let(:params) do
    { query: query, variables: variables }
  end

  xit "should return the expected response" do
    post(graphql_url, params: params)

    expect(response).to have_http_status :ok
    body = response.parsed_body

    expect(body["errors"]).not_to be, "errors: #{body["errors"]&.map { |error| error["message"] }&.join(', ')}"

    expect(body.dig("data", "user", "fullName")).to eq "#{user.first_name} #{user.last_name}"
  end
end