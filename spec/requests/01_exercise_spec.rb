require "rails_helper"

RSpec.describe "exercise 1", type: :request do
  let(:query) { file_fixture("01_exercise.graphql").read }
  let(:params) do
    { query: query }
  end

  it "should return the expected response" do
    post(graphql_url, params: params)

    expect(response).to have_http_status :ok
    body = response.parsed_body

    expect(body["errors"]).not_to be, "errors: #{body["errors"]&.map { |error| error["message"] }&.join(', ')}"
    expect(body.dig("data", "myArrayField")).to eq ["item"]
    expect(body.dig("data", "myBooleanField")).to eq true
    expect(body.dig("data", "myIntegerField")).to eq 13
    expect(body.dig("data", "myTextField")).to eq "bookclub rulz"
  end
end