require 'rails_helper'

RSpec.describe 'Relationships' do 
  describe 'Merchants Relationships' do
    it 'returns a collection of items associated with a merchant' do 
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      item_1 = create(:item, merchant: merchant_1)
      item_2 = create(:item, merchant: merchant_1)
      item_3 = create(:item, merchant: merchant_1)
      item_4 = create(:item, merchant: merchant_2)

      get "/api/v1/merchants/#{merchant_1.id}/items"

      expect(response).to be_successful 

      items = JSON.parse(response.body)

      expect(items["data"].count).to eq(3)
      expect(items["data"][0]["attributes"]["merchant_id"]).to eq(merchant_1.id)
      expect(items["data"][1]["attributes"]["merchant_id"]).to eq(merchant_1.id)
      expect(items["data"][2]["attributes"]["merchant_id"]).to eq(merchant_1.id)
    end 

    it 'returns a collection of invoices associated with a merchant from known orders' do 
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      invoice_1 = create(:invoice, merchant: merchant_1)
      invoice_2 = create(:invoice, merchant: merchant_1)
      invoice_3 = create(:invoice, merchant: merchant_2)

      get "/api/v1/merchants/#{merchant_1.id}/invoices"

      expect(response).to be_successful 

      invoices = JSON.parse(response.body)

      expect(invoices["data"].count).to eq(2)
      expect(invoices["data"][0]["attributes"]["merchant_id"]).to eq(merchant_1.id)
      expect(invoices["data"][1]["attributes"]["merchant_id"]).to eq(merchant_1.id)
    end 
  end 
end 