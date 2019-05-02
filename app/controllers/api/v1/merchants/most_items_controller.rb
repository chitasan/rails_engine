class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    merchants_ranked = Merchant.merchants_ranked_by_total_items_sold(params[:quantity])
    render json: MerchantSerializer.new(merchants_ranked)
  end 
end 