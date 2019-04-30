require 'rails_helper'

describe 'Merchants API' do 
  it 'sends a list of all merchants' do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)
  end

  it 'can return one merchant by merchant id' do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["id"]).to eq(merchant.id)
  end 
end 