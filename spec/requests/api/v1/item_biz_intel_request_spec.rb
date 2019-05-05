require 'rails_helper'

RSpec.describe 'Items API Business Intelligence' do
  describe 'All Items' do 
    it 'returns the top x items ranked by total revenue generated' do 
      item_1 = create(:item)
      item_2 = create(:item)
      item_3 = create(:item)
      item_4 = create(:item)
    
      invoice_1 = create(:invoice)
      invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 1, unit_price: 1)
    
      invoice_2 = create(:invoice)
      invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_2, quantity: 2, unit_price:2)
    
      invoice_3 = create(:invoice)
      invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item_3, quantity: 3, unit_price: 3)

      invoice_4 = create(:invoice)
      invoice_item_4 = create(:invoice_item, invoice: invoice_4, item: item_3, quantity: 4, unit_price: 3)

      invoice_5 = create(:invoice)
      invoice_item_5 = create(:invoice_item, invoice: invoice_5, item: item_3, quantity: 5, unit_price:3)

      create(:transaction, invoice: invoice_1, result: 0)
      create(:transaction, invoice: invoice_2, result: 0)
      create(:transaction, invoice: invoice_3, result: 0)
      create(:transaction, invoice: invoice_4, result: 0)
      create(:transaction, invoice: invoice_5, result: 0)

      get '/api/v1/items/most_revenue?quantity=2'

      expect(response).to be_successful
      items_returned = JSON.parse(response.body)
      expect(items_returned["data"].count).to eq(2)
      expect(items_returned["data"][0]["attributes"]["id"]).to eq(Item.items_with_most_revenue(2)[0].id)
    end 

    it 'retuns the top x item instances ranked by total number sold' do 
      item_1 = create(:item)
      item_2 = create(:item)
      item_3 = create(:item)
      item_4 = create(:item)
    
      invoice_1 = create(:invoice)
      invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 1, unit_price: 1)
    
      invoice_2 = create(:invoice)
      invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_2, quantity: 2, unit_price:2)
    
      invoice_3 = create(:invoice)
      invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item_3, quantity: 3, unit_price: 3)

      invoice_4 = create(:invoice)
      invoice_item_4 = create(:invoice_item, invoice: invoice_4, item: item_3, quantity: 4, unit_price: 3)

      invoice_5 = create(:invoice)
      invoice_item_5 = create(:invoice_item, invoice: invoice_5, item: item_3, quantity: 5, unit_price:3)

      create(:transaction, invoice: invoice_1, result: 0)
      create(:transaction, invoice: invoice_2, result: 0)
      create(:transaction, invoice: invoice_3, result: 0)
      create(:transaction, invoice: invoice_4, result: 0)
      create(:transaction, invoice: invoice_5, result: 0)

      get '/api/v1/items/most_items?quantity=2'

      expect(response).to be_successful
      items_returned = JSON.parse(response.body)
      expect(items_returned["data"].count).to eq(2)
      expect(items_returned["data"][0]["attributes"]["id"]).to eq(Item.items_by_inventory_sold(2)[0].id)
    end
  end 

  describe 'Single Item' do 
    xit 'returns the date with the most sales for the given item using the invoice date, and returns the most recent day if there are multiple days with same amount of sales' do 
      item = create(:item)
    
      invoice_1 = create(:invoice, created_at: "2012-03-12 03:54:10 UTC")
      invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item, quantity: 1, unit_price: 1)
    
      invoice_2 = create(:invoice, created_at: "2012-03-13 03:54:10 UTC")
      invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item, quantity: 2, unit_price:2)
    
      invoice_3 = create(:invoice, created_at: "2012-03-13 03:54:10 UTC")
      invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item, quantity: 3, unit_price: 3)

      invoice_4 = create(:invoice, created_at: "2012-03-14 03:54:10 UTC")
      invoice_item_4 = create(:invoice_item, invoice: invoice_4, item: item, quantity: 4, unit_price: 3)

      invoice_5 = create(:invoice, created_at: "2012-03-15 03:54:10 UTC")
      invoice_item_5 = create(:invoice_item, invoice: invoice_5, item: item, quantity: 3, unit_price:3)

      create(:transaction, invoice: invoice_1, result: 0)
      create(:transaction, invoice: invoice_2, result: 0)
      create(:transaction, invoice: invoice_3, result: 0)
      create(:transaction, invoice: invoice_4, result: 0)
      create(:transaction, invoice: invoice_5, result: 0)

      get "/api/v1/items/#{item.id}/best_day"
  
      expect(response).to be_successful
      # returned_date = JSON.parse(response.body)
      # expect(returned_date["data"]["best_day"]).to eq("2012-03-13 03:54:10 UTC")
    end 
  end 
end 