require 'rails_helper'

RSpec.describe 'Merchants API: Business Intelligence' do
  describe 'All Merchants' do
    it 'returns the top x merchants ranked by total revenue' do
      customer = create(:customer)

      merchant_1 = create(:merchant)
      item_1 = create(:item, merchant: merchant_1)
      invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
      invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1, unit_price: 2, quantity: 1)
      transaction_1 = create(:transaction, invoice: invoice_1, result: 0)
      
      merchant_2 = create(:merchant)
      item_2 = create(:item, merchant: merchant_2)
      invoice_2 = create(:invoice, merchant: merchant_2, customer: customer)
      invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_2, unit_price: 4, quantity: 1)
      transaction_2 = create(:transaction, invoice: invoice_2, result: 0)

      merchant_3 = create(:merchant)
      item_3 = create(:item, merchant: merchant_3)
      invoice_3 = create(:invoice, merchant: merchant_3, customer: customer)
      invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item_3, unit_price: 6, quantity: 1)
      transaction_3 = create(:transaction, invoice: invoice_3, result: 0)

      merchant_4 = create(:merchant)
      item_4 = create(:item, merchant: merchant_4)
      invoice_4 = create(:invoice, merchant: merchant_4, customer: customer)
      invoice_item_4 = create(:invoice_item, invoice: invoice_4, item: item_4, unit_price: 6, quantity: 1)
      transaction_4 = create(:transaction, invoice: invoice_4, result: 1)

      get '/api/v1/merchants/most_revenue?quantity=2'
      merchants_returned = JSON.parse(response.body)
      merchants_ranked = Merchant.merchants_ranked_by_total_revenue(2)

      expect(response).to be_successful
      expect(merchants_returned["data"].count).to eq(2)
      expect(merchants_returned["data"][0]["id"]).to eq(merchants_ranked.first.id.to_s)
      expect(merchants_returned["data"][1]["id"]).to eq(merchants_ranked.last.id.to_s)
      expect(merchants_returned["data"][0]["id"]).to eq(merchant_3.id.to_s)
      expect(merchants_returned["data"][1]["id"]).to eq(merchant_2.id.to_s)

      get '/api/v1/merchants/most_revenue?quantity=3'
      
      merchants_ranked = Merchant.merchants_ranked_by_total_revenue(3)
      merchants_returned = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants_returned["data"].count).to eq(3)
      # expect(merchants_returned["data"][0]["id"]).to eq(merchants_ranked.first.id.to_s)
      # expect(merchants_returned["data"][1]["id"]).to eq(merchants_ranked.second.id.to_s)
      # expect(merchants_returned["data"][2]["id"]).to eq(merchants_ranked.last.id.to_s)
      expect(merchants_returned["data"][0]["id"]).to eq(merchant_3.id.to_s)
      expect(merchants_returned["data"][1]["id"]).to eq(merchant_2.id.to_s)
      expect(merchants_returned["data"][2]["id"]).to eq(merchant_1.id.to_s)
    end 

    it 'returns top x merchants ranked by total numbers of items sold' do 
      customer = create(:customer)

      merchant_1 = create(:merchant)
      item_1 = create(:item, merchant: merchant_1)
      invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
      invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1, unit_price: 2, quantity: 1)
      transaction_1 = create(:transaction, invoice: invoice_1, result: 0)
      
      merchant_2 = create(:merchant)
      item_2 = create(:item, merchant: merchant_2)
      item_3 = create(:item, merchant: merchant_2)
      invoice_2 = create(:invoice, merchant: merchant_2, customer: customer)
      invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_2, unit_price: 4, quantity: 2)
      invoice_item_3 = create(:invoice_item, invoice: invoice_2, item: item_3, unit_price: 4, quantity: 2)
      transaction_2 = create(:transaction, invoice: invoice_2, result: 0)

      merchant_3 = create(:merchant)
      item_4 = create(:item, merchant: merchant_3)
      invoice_3 = create(:invoice, merchant: merchant_3, customer: customer)
      invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item_4, unit_price: 6, quantity: 3)
      transaction_3 = create(:transaction, invoice: invoice_3, result: 0)

      merchant_4 = create(:merchant)
      item_5 = create(:item, merchant: merchant_4)
      invoice_4 = create(:invoice, merchant: merchant_4, customer: customer)
      invoice_item_4 = create(:invoice_item, invoice: invoice_4, item: item_5, unit_price: 6, quantity: 10)
      transaction_4 = create(:transaction, invoice: invoice_4, result: 1)

      get '/api/v1/merchants/most_items?quantity=2'

      merchants_ranked = Merchant.merchants_ranked_by_total_items_sold(2)
      merchants_returned = JSON.parse(response.body)
   
      expect(response).to be_successful
      expect(merchants_returned["data"].count).to eq(2)
      # expect(merchants_returned["data"][0]["id"]).to eq(merchants_ranked.first.id.to_s)
      # expect(merchants_returned["data"][1]["id"]).to eq(merchants_ranked.last.id.to_s)
      expect(merchants_returned["data"][0]["id"]).to eq(merchant_2.id.to_s)
      expect(merchants_returned["data"][1]["id"]).to eq(merchant_3.id.to_s)

      get '/api/v1/merchants/most_items?quantity=3'

      merchants_ranked = Merchant.merchants_ranked_by_total_items_sold(3)
      merchants_returned = JSON.parse(response.body)
 
      expect(response).to be_successful
      expect(merchants_returned["data"].count).to eq(3)
      # expect(merchants_returned["data"][0]["id"]).to eq(merchants_ranked.first.id.to_s)
      # expect(merchants_returned["data"][1]["id"]).to eq(merchants_ranked.second.id.to_s)
      # expect(merchants_returned["data"][2]["id"]).to eq(merchants_ranked.last.id.to_s)
      expect(merchants_returned["data"][0]["id"]).to eq(merchant_2.id.to_s)
      expect(merchants_returned["data"][1]["id"]).to eq(merchant_3.id.to_s)
      expect(merchants_returned["data"][2]["id"]).to eq(merchant_1.id.to_s)
    end 

    it 'returns the total revenue for date x across all merchants' do 
      merchant = create(:merchant)
      customer = create(:customer)
      invoice_1 = create(:invoice, created_at: "2012-03-24 15:54:10 UTC", merchant: merchant, customer: customer)
      create(:transaction, invoice: invoice_1, result: 0)
      create(:invoice_item, invoice: invoice_1)

      invoice_2 = create(:invoice, created_at: "2012-03-24 15:54:10 UTC", merchant: merchant, customer: customer)
      create(:transaction, invoice: invoice_2, result: 0)
      create(:invoice_item, invoice: invoice_2)

      invoice_3 = create(:invoice, created_at: "2012-03-24 15:54:10 UTC", merchant: merchant, customer: customer)
      create(:transaction, invoice: invoice_3, result: 0)
      create(:invoice_item, invoice: invoice_3)

      invoice_4 = create(:invoice, created_at: "2012-03-24 15:54:10 UTC", merchant: merchant, customer: customer)
      create(:transaction, invoice: invoice_4, result: 1)
      create(:invoice_item, invoice: invoice_4)

      get '/api/v1/merchants/revenue?date=2012-03-24'

      revenue_returned = JSON.parse(response.body)

      expect(response).to be_successful
      expect(revenue_returned["data"]["attributes"]["total_revenue"]).to eq((Merchant.all_total_revenue_for_date("2012-03-24") / 100.0).to_s)
    end
  end 

  describe 'Single Merchants' do
    xit 'returns the total revenue for that merchant across successful transactions' do 
    end 

    xit 'returns the total revenue for that merchant for a specific invoice date x' do
    end 

    xit 'returns the customer who has conducted the most total number of successful transactions' do
    end 

    #boss mode
    xit "returns a collection of customers, which have unpaid invoices" do
    end 
  end 
end 