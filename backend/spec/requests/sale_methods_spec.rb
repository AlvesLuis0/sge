require 'rails_helper'

RSpec.describe "/sale_methods", type: :request do
  let(:valid_attributes) {
    { name: "Varejo", position: 1, status: StatusConstant.get_value(:active) }
  }

  let(:invalid_attributes) {
    { name: "", position: nil, status: 999 }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      SaleMethod.create! valid_attributes
      get sale_methods_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      sale_method = SaleMethod.create! valid_attributes
      get sale_method_url(sale_method), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new SaleMethod" do
        expect {
          post sale_methods_url,
               params: { sale_method: valid_attributes }, headers: valid_headers, as: :json
        }.to change(SaleMethod, :count).by(1)
      end

      it "renders a JSON response with the new sale_method" do
        post sale_methods_url,
             params: { sale_method: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new SaleMethod" do
        expect {
          post sale_methods_url,
               params: { sale_method: invalid_attributes }, as: :json
        }.to change(SaleMethod, :count).by(0)
      end

      it "renders a JSON response with errors for the new sale_method" do
        post sale_methods_url,
             params: { sale_method: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_content)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: "Atacado", position: 2, status: StatusConstant.get_value(:inactive) }
      }

      it "updates the requested sale_method" do
        sale_method = SaleMethod.create! valid_attributes
        patch sale_method_url(sale_method),
              params: { sale_method: new_attributes }, headers: valid_headers, as: :json
        sale_method.reload
        expect(sale_method.name).to eq(new_attributes[:name])
        expect(sale_method.position).to eq(new_attributes[:position])
        expect(sale_method.status).to eq(new_attributes[:status])
      end

      it "renders a JSON response with the sale_method" do
        sale_method = SaleMethod.create! valid_attributes
        patch sale_method_url(sale_method),
              params: { sale_method: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the sale_method" do
        sale_method = SaleMethod.create! valid_attributes
        patch sale_method_url(sale_method),
              params: { sale_method: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_content)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested sale_method" do
      sale_method = SaleMethod.create! valid_attributes
      expect {
        delete sale_method_url(sale_method), headers: valid_headers, as: :json
      }.to change(SaleMethod, :count).by(-1)
    end
  end
end
