require 'rails_helper'

RSpec.describe 'Customer API Business Intelligence' do 
  it 'returns a merchant where the customer has conducted the most successful transactions' do 
    customer = create(:customer)
    
    merchant_1 = create(:merchant)
    invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
    create(:transaction, invoice: invoice_1, result: 'success')
    
    merchant_2 = create(:merchant)
    invoice_2 = create(:invoice, merchant: merchant_2, customer: customer)
    invoice_3 = create(:invoice, merchant: merchant_2, customer: customer)
    invoice_4 = create(:invoice, merchant: merchant_2, customer: customer)
    invoice_5 = create(:invoice, merchant: merchant_2, customer: customer)
    create(:transaction, invoice: invoice_2, result: 0)
    create(:transaction, invoice: invoice_3, result: 0)
    create(:transaction, invoice: invoice_4, result: 0)
    create(:transaction, invoice: invoice_5, result: 0)
      
    merchant_3 = create(:merchant)
    invoice_6 = create(:invoice, merchant: merchant_3, customer: customer)
    invoice_7 = create(:invoice, merchant: merchant_3, customer: customer)
    invoice_8 = create(:invoice, merchant: merchant_3, customer: customer)
    invoice_9 = create(:invoice, merchant: merchant_3, customer: customer)
    invoice_10 = create(:invoice, merchant: merchant_3, customer: customer)
    create(:transaction, invoice: invoice_6, result: 0)
    create(:transaction, invoice: invoice_7, result: 0)
    create(:transaction, invoice: invoice_8, result: 0)
    create(:transaction, invoice: invoice_9, result: 1)
    create(:transaction, invoice: invoice_10, result: 1)
    
    get "/api/v1/customers/#{customer.id}/favorite_merchant"
    
    expect(response).to be_successful
    
    merchant = JSON.parse(response.body)
    expect(merchant.count).to eq(1)
    expect(merchant["data"]["attributes"]["id"]).to eq(customer.favorite_merchant.id)
  end 
end 