require 'rails_helper'

describe 'Merchants API' do 
  it 'sends a list of all merchants' do
    merchant_1, merchant_2, merchant_3 = create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants["data"].count).to eq(3)
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  it 'can return a random merchant' do
    create_list(:merchant, 10)

    get "/api/v1/merchants/random"

    merchant = JSON.parse(response.body)
 
    expect(response).to be_successful
    expect(merchant.size).to eq(1)
  end 

  describe 'find a merchant' do 
    it 'by id attribute' do 
      id = create(:merchant).id

      get "/api/v1/merchants/find?id=#{id}"

      merchant = JSON.parse(response.body)
 
      expect(response).to be_successful
      expect(merchant["data"]["id"]).to eq(id.to_s)
    end  

    it 'by name attribute' do 
      name = create(:merchant).name

      get "/api/v1/merchants/find?name=#{name}"

      merchant = JSON.parse(response.body)
    
      expect(response).to be_successful
      expect(merchant["data"]["attributes"]["name"]).to eq(name)
    end  

    it 'by created_at attribute' do 
      merchant, merchant_2 = create_list(:merchant, 2)

      get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

      merchant_returned = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant_returned["data"]["attributes"]["name"]).to eq(merchant.name)

      get "/api/v1/merchants/find?created_at=#{merchant_2.created_at}"

      merchant_2_returned = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant_2_returned["data"]["attributes"]["name"]).to eq(merchant_2.name)
    end  

    it 'by updated_at attribute' do 
      merchant_1 = create(:merchant, updated_at: '2012-03-28 14:53:59 UTC')
      merchant_2 = create(:merchant, updated_at: '2013-03-28 14:53:59 UTC')

      get "/api/v1/merchants/find?updated_at=#{merchant_1.updated_at}"

      merchant_1_returned = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant_1_returned["data"]["attributes"]["name"]).to eq(merchant_1.name)

      get "/api/v1/merchants/find?updated_at=#{merchant_2.updated_at}"

      merchant_2_returned = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant_2_returned["data"]["attributes"]["name"]).to eq(merchant_2.name)
    end  
  end 

  describe 'find all merchants' do 
    it 'by id attribute' do 
      id = create(:merchant).id 

      get "/api/v1/merchants/find_all?id=#{id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      
      expect(merchant["data"][0]["id"]).to eq(id.to_s)
    end 

    it 'by name attribute' do 
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant, name: "Pie")

      get "/api/v1/merchants/find_all?name=Jim Bob"
      
      merchants_returned = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants_returned["data"][0]["attributes"]["name"]).to eq(merchant_1.name)
      expect(merchants_returned["data"][1]["attributes"]["name"]).to eq(merchant_2.name)

      expect(merchants_returned["data"].length).to eq(2)
    end 

    it 'by created_at attribute' do 
      merchant_1 = create(:merchant, created_at: '2012-03-28 14:53:59 UTC')
      merchant_2 = create(:merchant, created_at: '2012-03-28 14:53:59 UTC')
      merchant_3 = create(:merchant, created_at: '2013-04-28 14:53:59 UTC')

      get "/api/v1/merchants/find_all?created_at=2012-03-28 14:53:59 UTC"

      merchants_returned = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants_returned["data"][0]["attributes"]["name"]).to eq(merchant_1.name)
      expect(merchants_returned["data"][1]["attributes"]["name"]).to eq(merchant_2.name)

      expect(merchants_returned["data"].length).to eq(2)
    end 

    it 'by updated_at attribute' do 
      merchant_1 = create(:merchant, updated_at: '2012-03-28 14:53:59 UTC')
      merchant_2 = create(:merchant, updated_at: '2012-03-28 14:53:59 UTC')
      merchant_3 = create(:merchant, updated_at: '2013-04-28 14:53:59 UTC')

      get "/api/v1/merchants/find_all?updated_at=2012-03-28 14:53:59 UTC"

      merchants_returned = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants_returned["data"][0]["attributes"]["name"]).to eq(merchant_1.name)
      expect(merchants_returned["data"][1]["attributes"]["name"]).to eq(merchant_2.name)

      expect(merchants_returned["data"].length).to eq(2)
    end 
  end 
end 