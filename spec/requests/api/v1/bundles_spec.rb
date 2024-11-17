require 'rails_helper'

RSpec.describe "Api::V1::BundlesController", type: :request do
  let(:valid_request) do
    {
      topics: {
        reading: 20,
        math: 50,
        science: 30,
        history: 15,
        art: 10
      }
    }
  end

  let(:json_response) { JSON.parse(response.body) }

  describe "POST /api/v1/bundles" do
    context "with valid request data" do
      before do
        allow(::Bundles::Create).to receive(:call).and_return(OpenStruct.new(
          quotes: {
            "provider_a" => 8.0,
            "provider_b" => 5.0,
            "provider_c" => 10.0
          }
        ))
      end

      it "returns ok" do
        post "/api/v1/bundles", params: valid_request, as: :json

        expect(response).to have_http_status(:ok)
        expect(json_response).to eq(
          "provider_a" => 8.0,
          "provider_b" => 5.0,
          "provider_c" => 10.0
        )
      end
    end

    context "with missing topics in request" do
      it "returns a bad request error" do
        post "/api/v1/bundles", params: {}, as: :json

        expect(response).to have_http_status(:bad_request)
        expect(json_response["error"]).to eq("Bad Request")
      end
    end
  end
end
