require "rails_helper"

RSpec.describe "exercise 0", type: :request do
  let!(:current_user) { create(:user) }
  let(:query) { file_fixture("00_exercise.graphql").read }
  let(:headers) do
    { "Authorization" => "bearer #{current_user.id}" }
  end
  let(:params) do
    { query: query }
  end

  it "should return the expected response" do
    post(graphql_url, headers: headers, params: params)

    expect(response).to have_http_status :ok
    body = response.parsed_body

    expect(body["errors"]).not_to be, "errors: #{body["errors"]&.map { |error| error["message"] }&.join(', ')}"
    data_current_user = body.dig("data", "currentUser")
    expect(data_current_user["id"]).to eq current_user.id
    expect(data_current_user["firstName"]).to eq current_user.first_name
  end
end